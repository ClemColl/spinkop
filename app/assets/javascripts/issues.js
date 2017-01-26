//= require components/core/main
//= require partials/admin
//= require components/search

var issues = {
	form: {
		element: document.querySelector('.new_issue, .edit_issue'),
		inputs: {
			theme: document.querySelector('#issue_theme'),
			theme_id: document.querySelector('#issue_theme_id')
		},
		init: function() {
			if(this.element) {
				var self = this;
				search.themes.watch(this.inputs.theme, function(result) {
					self.inputs.theme_id.value = result.id;
				});
			}
		}
	},
	init: function() {
		this.form.init();
	}
};

main.exec('issues', [
	'search'
]);
