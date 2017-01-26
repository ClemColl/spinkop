//= require components/core/main
//= require partials/admin

var users = {
	form: {
		element: document.querySelector('.new_user, .edit_user'),
		inputs: {
			password: document.querySelector('#user_password'),
			password_confirmation: document.querySelector('#user_password_confirmation'),
			password_random: document.querySelector('#user_password_random')
		},
		password: {
			length: 16,
			char: {
				list: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
				get random() {
					return this.list[Math.floor(Math.random()*this.list.length)];
				}
			},
			get random() {
				var password = '';
				for(var i = 0; i < this.length; i++) password += this.char.random;

				return password;
			}
		},
		init: function() {
			if(this.element) {
				var self = this;

				this.inputs.password_random.on('click', function() {
					var password = self.password.random;
					self.inputs.password.value = password;
					self.inputs.password_confirmation.value = password;
					self.inputs.password_random.value = password;
					setTimeout(function() {
						self.inputs.password_random.focus();
						self.inputs.password_random.select();
					}, 1);
				});
			}
		}
	},
	init: function() {
		this.form.init();
	}
};

main.exec('users', [
	'eventsManager'
]);
