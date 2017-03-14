main.init('splash', [
	'nodeUtils'
]);

var splash = {
	element: document.querySelector('.splash'),
	transition: 500,
	get hidden() {
		return this.element.getAttribute('data-hidden') !== null;
	},
	set hidden(v) {
		if(v) {
			this.element.setAttribute('data-hidden', '');
			document.body.style.overflow = null;
		}
		else {
			this.element.removeAttribute('data-hidden');
			document.body.style.overflow = 'hidden';
		}
	},
	remove: function() {
		this.element.remove();
	},
	hide: function(callback) {
		var self = this;

		if(typeof callback != 'function') callback = function() {};

		this.hidden = true;

		setTimeout(function() {
			self.remove();
			callback();
		}, this.transition);
	},
	show: function(color, callback) {
		var self = this;

		if(typeof color == 'function') {
			callback = color;
			color = undefined;
		}

		if(color !== undefined) this.color = color;


		this.hidden = true;
		if(!this.element.parentNode) document.body.appendChild(this.element);
		setTimeout(function() {
			self.hidden = false;
		}, 1);

		if(typeof callback == 'function') {
			setTimeout(function() {
				callback();
			}, this.transition + 1);
		}
	},
	get color() {
		return this.element.style.backgroundColor;
	},
	set color(v) {
		this.element.style.backgroundColor = v;
	},
	init: function() {
		if(this.element === null) {
			this.element = document.createElement('div');
			this.element.className = 'splash';
		}
		else {
			var self = this;

			setTimeout(function() {
				self.hide();
			}, 1);
		}
	}
};
