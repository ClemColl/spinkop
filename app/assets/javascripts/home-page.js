//= require components/core/main
//= require components/form
//= require components/search
//= require components/splash

var homePage = {
	element: document.querySelector('.themes'),
	elements: document.querySelectorAll('.theme'),
	input: document.querySelector('.search'),
	get initialized() {
		return this.element.getAttribute('data-initialized') !== null;
	},
	set initialized(v) {
		if(v) this.element.setAttribute('data-initialized', '');
		else this.element.removeAttribute('data-initialized');
	},
	position: function(element) {
		var scale = typeof element.scale == 'number' ? element.scale : 1;
		var boundingClientRect = element.getBoundingClientRect();

		return {
			x: boundingClientRect.left+(scale*element.offsetWidth/2),
			y: boundingClientRect.top+(scale*element.offsetHeight/2)
		};
	},
	delta: function(element, x, y) {
		var position = this.position(element);
		return {
				x: x - position.x,
				y: y - position.y
		};
	},
	ease: function(x) {
		return Math.pow(x-1, 3)+1;
	},
	ratio: function(element, x, y, abs) {
		var delta = this.delta(element, x, y);
		var area = this.element.offsetWidth+this.element.offsetHeight;
		var ratio = (abs === false ? delta.x+delta.y : (Math.abs(delta.x)+Math.abs(delta.y)))/area;

		return this.ease(ratio > 1 ? 1 : (ratio < 0 ? 0 : ratio));
	},
	translate: function(element, x, y) {
		var ratio = this.ratio(element, x, y, false);
		ratio = ratio > 1 ? 1 : (ratio < 0 ? 0 : ratio);
		return ratio*100;
	},
	scale: function(element, x, y) {
		var ratio = 1-this.ratio(element, x, y);
		return ratio < 0.2 ? 0.2 : ratio;
	},
	mousemove: function(event, init) {
		var x = event.clientX;
		var y = event.clientY;

		for(var i = 0; i < homePage.elements.length; i++) {
			var element = homePage.elements[i];
			if(element.getAttribute('data-opening') === null) {
				element.scale = homePage.scale(element, x, y);
				element.style.transform = 'scale('+element.scale+')';
				if(element.filled) {
					element.overlay.style.opacity = homePage.ratio(element, x, y)*0.2+0.8;
					element.infos.style.color = 'rgba(255, 255, 255, '+(1-homePage.ratio(element, x, y))+')';
				}
			}
		}

		if(!init && !homePage.initialized) homePage.initialized = true;
	},
	// mousedown: function() {
	// 	var self = this;
	//
	// 	this.setAttribute('data-opening', '');
	// 	var coordinates = this.getBoundingClientRect();
	// 	this.questions.style.top = coordinates.top+'px';
	// 	this.questions.style.left = coordinates.left+'px';
	//
	// 	setTimeout(function() {
	// 		self.removeAttribute('data-opening', '');
	// 		self.setAttribute('data-open', '');
	// 		setTimeout(function() {
	// 			self.questions.style.top = 0;
	// 			self.questions.style.left = 0;
	// 		}, 1);
	// 	}, 1);
	// },
	click: function(element) {
		var transition = element.querySelector('.theme-transition');
		return function(event) {
			var coordinates = transition.getBoundingClientRect();
			transition.style.top = coordinates.top+'px';
			transition.style.left = coordinates.left+'px';
			transition.remove();
			transition.setAttribute('data-opening', '');
			document.body.appendChild(transition);

			setTimeout(function() {
				size = window.innerWidth > window.innerHeight ? window.innerWidth*2 : window.innerHeight*2;
				transition.style.width = size+'px';
				transition.style.height = size+'px';
				transition.style.top = -size*0.25+'px';
				transition.style.left = -size*0.25+'px';
				transition.style.borderRadius = size+'px';
			}, 1);

			setTimeout(function() {
				window.location.href = element.href;
			}, 401);

			event.preventDefault();
		};
	},
	init: function() {
		for(var i = 0; i < this.elements.length; i++) {
			var element = this.elements[i];
			element.overlay = element.querySelector('.overlay');
			element.infos = element.querySelector('.infos');
			element.color = element.getAttribute('data-color');

			element.filled = element.overlay instanceof Node && element.infos instanceof Node;

			if(element.filled) element.on('click', this.click(element));
		}

		this.input.parentNode.parentNode.on('submit', function(event) {
			event.preventDefault();
		});

		search.all.watch(this.input, function(result) {
			var path;

			if(result.type == 'article') path = routes.issue_page(result.issue_id)+'#'+result.id;
			else path = routes[result.type+'_page'](result.id);

			window.location.href = path;
		}, function(result) {
			if(result.type == 'tag') return 'Tag: '+result.content;
			else if(result.type == 'theme') return 'Thème: '+result.content;
			else return result.content;
		});

		window.on('mousemove', this.mousemove);
		this.mousemove({
			clientX: 0,
			clientY: 0
		}, true);
	}
};


main.exec('homePage', [
	'eventsManager',
	'search'
]);
