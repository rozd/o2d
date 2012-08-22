package com.github.rozd.o2d.infrastructure.impl
{
	import com.adobe.protocols.oauth2.OAuth2;
	import com.adobe.protocols.oauth2.event.GetAccessTokenEvent;
	import com.adobe.protocols.oauth2.grant.AuthorizationCodeGrant;
	import com.adobe.protocols.oauth2.grant.IGrantType;
	import com.github.rozd.o2d.infrastructure.AuthorizationService;
	
	import flash.media.StageWebView;
	
	import mx.core.mx_internal;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.as3commons.logging.setup.LogSetupLevel;
	
	use namespace mx_internal;
	
	public class AuthorizationServiceImpl implements AuthorizationService
	{
		public function AuthorizationServiceImpl()
		{
			super();
		}
		
		[Inject]
		public var stageWebView:StageWebView;
		
		[Inject("clientID")]
		public var clientID:String;
		
		[Inject("clientSecret")]
		public var clientSecret:String;

		[Inject("redirectURI")]
		public var redirectURI:String;
		
		public function getAccess():AsyncToken
		{
			var oauth2:OAuth2 = new OAuth2("https://accounts.google.com/o/oauth2/auth", "https://accounts.google.com/o/oauth2/token", LogSetupLevel.DEBUG);
			var grant:IGrantType = new AuthorizationCodeGrant(stageWebView, clientID, clientSecret, redirectURI, "https://www.googleapis.com/auth/userinfo.profile");
			
			oauth2.addEventListener(GetAccessTokenEvent.TYPE, onGetAccessToken);
			oauth2.getAccessToken(grant);
			
			const token:AsyncToken = new AsyncToken();
			
			const onGetAccessToken:Function = function(event:GetAccessTokenEvent):void
			{
				if (event.errorCode)
				{
					token.applyFault(FaultEvent.createEvent(new Fault(event.errorCode, event.errorMessage), token));
				}
				else
				{
					token.applyResult(ResultEvent.createEvent(event, token));
				}
			};
				
			return token;
		}
	}
}