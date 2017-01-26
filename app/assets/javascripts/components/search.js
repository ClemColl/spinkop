var search = {
	fields: ['all', 'themes', 'issues', 'articles', 'tags'],
	request: function(field) {
		var url = routes[(field == 'all' ? '' : field+'_')+'search'];
		return url ? new Request(url, null, 'get', true) : null;
	},
	get: function(field) {
		return function(input, params, callback) {
			if(callback === undefined && typeof params == 'function') {
				callback = params;
				params = {};
			}

			if(typeof params != 'object' || params === null) params = {};
			if(typeof callback != 'function') callback = function() {};

			params.q = input;

			this.request.success(callback).send(params);
		};
	},
	results: function(element) {
		var results = element.nextSibling ? (element.nextSibling.tagName == 'UL' ? element.nextSibling : null) : null;

		if(!results) {
			results = document.createElement('ul');
			element.after(results);
		}

		return results;
	},
	clearResults: function(element) {
		var results = this.results(element).querySelectorAll('li[data-selected]');
		for(var i = 0; i < results.length; i++) results[i].removeAttribute('data-selected');
	},
	keydown: function(field) {
		return function(event) {
			if(event.keyCode == 38) {
				var results = search.results(this).querySelectorAll('li');
				if(results.length > 0) {
					this.search.offset--;
					if(this.search.offset < 0) this.search.offset = results.length - 1;
					search.clearResults(this);
					results[this.search.offset].setAttribute('data-selected');
					event.preventDefault();
				}
			}
			else if(event.keyCode == 40) {
				var results = search.results(this).querySelectorAll('li');
				if(results.length > 0) {
					this.search.offset++;
					if(this.search.offset >= results.length) this.search.offset = 0;
					search.clearResults(this);
					results[this.search.offset].setAttribute('data-selected');
					event.preventDefault();
				}
			}
			else if(event.keyCode == 13) {
				var results = search.results(this).querySelectorAll('li');
				if(results.length > 0) {
					if(this.search.offset >= 0 && this.search.offset < results.length) {
						var result = results[this.search.offset]
						this.value = result.search.content;
						this.removeAttribute('data-search');
						if(typeof this.search.callback == 'function') this.search.callback(result.search);
						search.results(this).remove();
						event.preventDefault();
					}
				}
			}
			else {
				var self = search[field];
				var element = this;
				element.search.offset = -1;
				search.clearResults(element);
				setTimeout(function() {
					if(element.value === '') {
						search.results(element).clear();
						if(element.getAttribute('data-search') !== null) element.removeAttribute('data-search');
					}
					else {
						self.get(element.value, element.params, function(response) {
							var li, result;
							var results = search.results(element);
							results.clear();

							for(var i = 0; i < response.length; i++) {
								result = response[i];
								li = document.createElement('li');
								li.text(result.content);
								li.search = result;
								li.on('mousedown', function() {
									element.value = this.search.content;
									element.removeAttribute('data-search');
									if(typeof element.search.callback == 'function') element.search.callback(this.search);
									search.results(element).remove();
								});
								results.append(li);
							}

							if(response.length != 0) element.setAttribute('data-search', '');
							else element.removeAttribute('data-search');
						});
					}
				}, 1);
			}
		};
	},
	focus: function(field) {
		var self = this;
		return function() {
			if(self.results(this).querySelectorAll('li').length > 0) this.setAttribute('data-search', '');
			else this.removeAttribute('data-search');
		};
	},
	blur: function(field) {
		return function() {
			this.removeAttribute('data-search');
		};
	},
	watch: function(field) {
		return function(element, callback) {
			element.setAttribute('autocomplete', "off");
			element.setAttribute('autocorrect', "off");
			element.setAttribute('spellcheck', "false");
			element.search = {
				callback: callback,
				offset: -1
			};

			element.on('keydown', this.keydown);
			element.on('focus', this.focus);
			element.on('blur', this.blur);
		};
	},
	unwatch: function(field) {
		var self = this;
		return function(element) {
			element.no('keydown', this.keydown);
			element.no('focus', this.focus);
			element.no('blur', this.blur);
			element.search = null;

			self.results(element).remove();
		};
	},
	add: function(field) {
		if(this[field] === undefined) {
			this[field] = {
				request: this.request(field),
				get: this.get(field),
				keydown: this.keydown(field),
				focus: this.focus(field),
				blur: this.blur(field),
				watch: this.watch(field),
				unwatch: this.unwatch(field)
			};
		}
	},
	init: function() {
		for(var i = 0; i < this.fields.length; i++) this.add(this.fields[i]);
	}
};
main.exec('search', [
	'Request',
	'eventsManager',
	'nodeUtils'
]);
