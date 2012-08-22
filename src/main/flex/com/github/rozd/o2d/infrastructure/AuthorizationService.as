package com.github.rozd.o2d.infrastructure
{
	import mx.rpc.AsyncToken;

	public interface AuthorizationService
	{
		function getAccess():AsyncToken;
	}
}