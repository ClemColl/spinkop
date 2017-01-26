//= require components/core/main
//= require partials/admin

var articles = {
	form: {
		element: document.querySelector('.new_article, .edit_article'),
		inputs: {
			issue: document.querySelector('#article_issue'),
			issue_id: document.querySelector('#article_issue_id'),
			tag: document.querySelector('#article_tag'),
			content: document.querySelector('#article_content')
		},
		tags: {
			get element() {
				return articles.form.element.querySelector('.tags');
			},
			get elements() {
				return this.element.querySelectorAll('span');
			},
			include: function(id) {
				var elements = this.elements;
				for(var i = 0; i < elements.length; i++) {
					if(elements[i].querySelector('input').value == id) return true;
				}

				return false;
			},
			reset: function() {
				var elements = this.elements;
				for(var i = 0; i < elements.length; i++) {
					elements[i].querySelector('input').name = 'article[tag_ids]['+i+']';
				}
			},
			init: function(tag) {
				if(tag instanceof Node) {
					var self = this;
					this.reset();
					tag.on('click', function() {
						this.remove();
						self.reset();
					});
				}
				else {
					var elements = this.elements;
					for(var i = 0; i < elements.length; i++) this.init(elements[i]);
				}
			}
		},
		init: function() {
			if(this.element) {
				var self = this;
				search.issues.watch(this.inputs.issue, function(result) {
					self.inputs.issue_id.value = result.id;
				});

				search.tags.watch(this.inputs.tag, function(result) {
					self.inputs.tag.value = '';

					if(!self.tags.include(result.id)) {
						var tag = document.createElement('span');
						tag.text(result.content);
						var input = document.createElement('input');
						input.type = 'hidden';
						input.value = result.id;
						tag.appendChild(input);
						self.tags.element.appendChild(tag);
						self.tags.init(tag);
					}
				});

				tinymce.init({
					selector: '#'+this.inputs.content.id
				});

				this.tags.init();
			}
		}
	},
	init: function() {
		this.form.init();
	}
};

main.exec('articles', [
	'search'
]);
