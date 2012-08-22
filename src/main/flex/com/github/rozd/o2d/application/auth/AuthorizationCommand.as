package com.github.rozd.o2d.application.auth
{
	import com.github.rozd.o2d.infrastructure.AuthorizationService;

	public class AuthorizationCommand
	{
		public function AuthorizationCommand()
		{
			super();
		}
		
		[Inject]
		public var service:AuthorizationService;
		
	}
}