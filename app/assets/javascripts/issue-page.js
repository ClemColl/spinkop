//= require components/core/main

var issuePage = {
	articles: {
		element: document.querySelector('.articles'),
		elements: document.querySelectorAll('.article'),
		get first() {
			return this.elements.length > 0 ? this.elements[0] : null;
		},
		dates: document.querySelectorAll('.timeline > span'),
		get selected() {
			return document.querySelectorAll('.timeline > span[data-selected]');
		},
		click: function(element, offset) {
			var self = this;

			return function() {
				for(var i = 0; i < self.selected.length; i++) {
					self.selected[i].removeAttribute('data-selected');
				}
				element.setAttribute('data-selected', '');
				self.first.style.marginLeft = -offset*100+'%';
			};
		},
		init: function() {
			if(this.element && this.first) {
				for(var i = 0; i < this.dates.length; i++) {
					this.dates[i].on('click', this.click(this.dates[i], i));
				}
			}
		}
	},
	init: function() {
		this.articles.init();
	}
};

main.exec('issuePage', [
	'eventsManager'
]);
