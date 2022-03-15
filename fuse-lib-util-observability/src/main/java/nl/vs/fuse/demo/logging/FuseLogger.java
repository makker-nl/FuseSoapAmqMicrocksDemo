package nl.vs.fuse.demo.logging;

import java.text.MessageFormat;
import java.util.List;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

import org.apache.camel.Exchange;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Class to support logging in Camel, with code-message lookup and keyword
 * expension.
 * 
 * @author Martien van den Akker
 *
 */
public class FuseLogger {
	private Logger log;
	public final String LOG_START_CODE = "HIP-001";
	public final String LOG_END_CODE = "HIP-099";
	public final String LOG_LEVEL_ERROR = "ERROR";
	public final String LOG_LEVEL_WARN = "WARNING";
	public final String LOG_LEVEL_INFO = "INFO";
	public final String LOG_LEVEL_DEBUG = "DEBUG";
	public final String LOG_DFT_LEVEL = LOG_LEVEL_INFO;
	public final List<String> LOG_VALID_LEVELS = List.of(LOG_LEVEL_ERROR, LOG_LEVEL_WARN, LOG_LEVEL_INFO,
			LOG_LEVEL_DEBUG);

	private final String MESSAGE_FORMAT = "{0} - {1}";
	private final String MSG_RECEIVED = "Message received: \n{0}";
	private final String MSG_RESPONDED = "Message responded: \n{0}";

	private ResourceBundle logInfo = ResourceBundle.getBundle("logInfo");
	private ResourceBundle logInfoLevel = ResourceBundle.getBundle("logInfoLevel");
	// Name used in the logger
	private String logName;
	// Application ID used to insert into the provided logCode
	private String logID;

	public FuseLogger() {
		super();
		if (log == null) {
			log = LoggerFactory.getLogger(FuseLogger.class);
		}
	}

	public FuseLogger(String logName) {
		super();
		setLogName(logName);
	}

	/**
	 * Create a log message.
	 * 
	 * @param code
	 * @param text
	 * @return
	 */
	private String formatMessage(String code, String text) {
		return MessageFormat.format(MESSAGE_FORMAT, code, text);
	}

	/**
	 * Comprise an App Log code from LogCode. Insert Application LogID into the
	 * provided logCode.
	 * 
	 * @param logCode
	 * @return
	 */
	private String getAppLogCode(String logCode) {
		int posDash = logCode.indexOf('-');
		String appLogCode = logCode.substring(0, posDash + 1) + getLogID() + logCode.substring(posDash);
		return appLogCode;
	}

	/**
	 * Do a log based on the logLevel.
	 * 
	 * @param logLevel
	 * @param text
	 */
	private void doLog(String logLevel, String text) {
		// Check if level from property file is a valid level
		if (!LOG_VALID_LEVELS.contains(logLevel)) {
			logLevel = LOG_DFT_LEVEL;
		}
		// Log based on level
		switch (logLevel) {
		case LOG_LEVEL_DEBUG:
			log.debug(text);
			break;
		case LOG_LEVEL_INFO:
			log.info(text);
			break;
		case LOG_LEVEL_WARN:
			log.warn(text);
			break;
		case LOG_LEVEL_ERROR:
			log.error(text);
		}
	}

	/**
	 * Do a log based on the log level from logCode.
	 * 
	 * @param logCode
	 * @param text
	 */
	private void doLogCode(String logCode, String text) {
		// Try to lookup log level
		String level = "";
		try {
			level = logInfoLevel.getString(logCode);
		} catch (MissingResourceException mre) {
			level = LOG_DFT_LEVEL;
		}
		doLog(level, text);
	}

	/**
	 * Log a message with a code. Looks up the message from logInfo using the code.
	 * 
	 * @param logCode
	 */
	public void logCode(String logCode) {
		String logInfoStr = formatMessage(getAppLogCode(logCode), logInfo.getString(logCode));
		doLogCode(logCode, logInfoStr);
	}

	/**
	 * Log a message with a code. Do a message format of the found logmessage using
	 * parameter1. Suggest to look in java-varargs
	 * (https://www.baeldung.com/java-varargs) to get an expandable list of
	 * parameters.
	 * 
	 * @param logCode
	 * @param parameter1
	 */
	public void logCode(String logCode, String parameter1) {
		String logInfoStr = logInfo.getString(logCode);
		String messageText = formatMessage(getAppLogCode(logCode), MessageFormat.format(logInfoStr, parameter1));
		doLogCode(logCode, messageText);
	}

	/**
	 * Perform a log for the start of the flow.
	 * 
	 * @param exchange
	 */
	public void logStart(Exchange exchange) {
		String body = exchange.getIn().getBody(String.class);
		logCode(LOG_START_CODE);
		String messageText = MessageFormat.format(MSG_RECEIVED, body);
		doLog(LOG_LEVEL_DEBUG, formatMessage(getAppLogCode(LOG_START_CODE), messageText));
	}

	/**
	 * Perform a log for the end of the flow.
	 * 
	 * @param exchange
	 */
	public void logEnd(Exchange exchange) {
		String body = exchange.getIn().getBody(String.class);
		logCode(LOG_END_CODE);
		String messageText = MessageFormat.format(MSG_RESPONDED, body);
		doLog(LOG_LEVEL_DEBUG, formatMessage(getAppLogCode(LOG_END_CODE), messageText));
	}

	public String getLogName() {
		return logName;
	}

	public void setLogName(String logName) {
		this.logName = logName;
		log = LoggerFactory.getLogger(logName);
	}

	public String getLogID() {
		return logID;
	}

	public void setLogID(String logID) {
		this.logID = logID;
	}

};
