# asp.js HTTP Request module

## Quick Example

```asp
<!--#INCLUDE VIRTUAL="/aspjs_modules/request/index.asp"-->
<%

var request = require("request");

request.get("http://...", function(err, response, body) {
	// ... error checks
});

request.post({
	url: "http://...",
	headers: {
		"x-custom-header": "value"
	},
	body: "", // Object, String or Buffer
	json: true,
	auth: {
		user: "username",
		pass: "password"
	},
	timeout: 15000
}, function(err, response, body) {
	// ... error checks
});

%>
```

## Documentation

inspired by [request](https://github.com/request/request).

<a name="license" />
## License

Copyright (c) 2016 Patrik Simek

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
