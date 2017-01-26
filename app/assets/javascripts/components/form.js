main.init('form', [
	'eventsManager'
]);

var form = {
	elements: document.querySelectorAll('form'),
	fields: document.querySelectorAll('.field'),
	input: function(field) {
		return field.querySelector('input, textarea, select');
	},
	focus: function(field) {
		return function() {
			field.setAttribute('data-focus', '');
		};
	},
	blur: function(field) {
		return function() {
			field.removeAttribute('data-focus');
		};
	},
	init: function() {
		for(var i = 0; i < this.fields.length; i++) {
			var field = this.fields[i];
			var input = this.input(field);
			if(input) {
				input.on('focus', this.focus(field));
				input.on('blur', this.blur(field));
			}
		}
	}
};
