//= require components/core/main
//= require components/form

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
		get hashchange() {
			var self = this;

			return function() {
				var id = window.location.hash.substring(1);
				var element;
				if(id.length > 0) {
					for(var i = 0; i < self.elements.length; i++) {
						if(self.elements[i].getAttribute('data-id') == id) {
							self.click(self.dates[i], i)();
							return;
						}
					}
				}
			};
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

				window.on('hashchange', this.hashchange);
				this.hashchange();
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
