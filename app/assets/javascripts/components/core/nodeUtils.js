main.init('nodeUtils');

var nodeUtils = {
	append: function(parent, element) {
		parent.appendChild(element);
	},
	prepend: function(parent, element) {
		if(parent.firstChild) parent.insertBefore(element, parent.firstChild);
		else parent.appendChild(element);
	},
	text: function(parent, text) {
		parent.appendChild(document.createTextNode(text));
	},
	clear: function(element) {
		element.innerHTML = '';
	},
	insertAfter: function(parent, element, refElement) {
		if(refElement.nextSibling) parent.insertBefore(element, refElement.nextSibling);
		else parent.appendChild(element);
	},
	before: function(refElement, element) {
		if(refElement.parentNode) refElement.parentNode.insertBefore(element, refElement);
	},
	after: function(refElement, element) {
		if(refElement.parentNode) refElement.parentNode.insertAfter(element, refElement);
	},
	remove: function(element) {
		if(element.parentNode) element.parentNode.removeChild();
	},
	apply: function(element) {
		element.append = function(element) {window.nodeUtils.append(this, element);};
		element.prepend = function(element) {window.nodeUtils.prepend(this, element);};
		element.text = function(text) {window.nodeUtils.text(this, text);};
		element.clear = function() {window.nodeUtils.clear(this);};
		element.insertAfter = function(element, refElement) {window.nodeUtils.insertAfter(this, element, refElement);};
		element.before = function(element) {window.nodeUtils.before(this, element);};
		element.after = function(element) {window.nodeUtils.after(this, element);};
	},
	init: function() {
		this.apply(Node.prototype);
	}
};
