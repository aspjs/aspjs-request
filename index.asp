<%

define('request', function(require, exports, module) {
	module.exports = function request(options, done) {
		if ('string' === typeof options) {
			options = {url: options};
		};
		
		options.headers = options.headers || {};
		options.method = options.method || 'GET';
		options.timeout = options.timeout || 60000;
		
		if (options.json) {
			options.headers['content-type'] = 'application/json';
			if ('object' === typeof options.body) options.body = JSON.stringify(options.body);
		} else if (options.form) {
			options.headers['content-type'] = 'application/x-www-form-urlencoded';
			if ('object' === typeof options.form) {
				var form = [];
				for (var field in options.form) {
					form.push(field +'='+ encodeURIComponent(options.form[field]));
				};
				options.body = form.join('&');
			};
		};
		
		var http = Server.CreateObject("WinHttp.WinHttpRequest.5.1");
		http.setTimeouts(30000, options.timeout, 30000, 30000);
		http.open(options.method, options.url, false);
		
		if (options.auth) http.setCredentials(options.auth.user, options.auth.pass, 0);
		http.option(6) = true; // allow redirects
		
		for (var header in options.headers) {
			http.setRequestHeader(header, options.headers[header]);
		};
	
		if (options.method === 'POST' && options.body) {
			if (!options.headers['content-type']) http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			if (!options.headers['content-length']) http.setRequestHeader('Content-Length', options.body.length);
			if (!options.headers['connection']) http.setRequestHeader('Connection', 'close');
		};
		
		var error = null, data, response;
		
		try {
			if (Buffer.isBuffer(options.body)) {
				http.send(options.body._buffer);
			} else {
				http.send(options.body);
			};
		} catch (ex) {
			ex.stack = ex.stack || Error.captureStackTrace();
			error = ex;
		};
	
		if (!error) {
			var headers = {};
			var headers = {}, rh = http.getAllResponseHeaders().split('\r\n');
			for (var i = 0, l = rh.length; i < l; i++) {
				if (rh[i]) headers[rh[i].substr(0, rh[i].indexOf(':')).toLowerCase()] = rh[i].substr(rh[i].indexOf(':') + 2);
			};
			
			try {
				data = http.responseText;
				if (options.json || /^application\/json/.test(headers['content-type'])) {
					data = JSON.parse(http.responseText);
				} else if (/^text\//.test(headers['content-type'])) {
					data = http.responseText;
				} else {
					data = new Buffer(http.responseBody);
				};
				
				response = {
					headers: headers,
					statusCode: http.status
				};
			} catch (ex) {
				ex.stack = ex.stack || Error.captureStackTrace();
				error = ex;
			};
		};
		
		done(error, response, data);
		return this;
	};
	
	module.exports.get = function get(options, done) {
		if ('string' === typeof options) {
			options = {url: options};
		};
		
		options.method = 'GET';
		
		return module.exports(options, done);
	};
	
	module.exports.post = function post(options, done) {
		if ('string' === typeof options) {
			options = {url: options};
		};
		
		options.method = 'POST';
		
		return module.exports(options, done);
	};
});

%>
