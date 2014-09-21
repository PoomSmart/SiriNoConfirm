#import <Preferences/PSSpecifier.h>

@interface AssistantController
- (void)setAssistantEnabled:(BOOL)enabled;
- (void)assistantDisabledConfirmed:(id)confirmed;
- (void)assistantEnabledConfirmed:(id)confirmed;
@end

%group SiriPrefHook

%hook AssistantController

- (void)setAssistantEnabled:(NSNumber *)value forSpecifier:(id)specifier
{
	BOOL enabled = [value intValue] == 1;
	[self setAssistantEnabled:enabled];
	if (enabled) {
		[self assistantEnabledConfirmed:specifier];
	}
	else {
		[self assistantDisabledConfirmed:specifier];
	}
}

%end

%end

%group PrefHook

%hook PrefController

- (void)lazyLoadBundle:(PSSpecifier *)bundle
{
	%orig;
	if ([bundle.name isEqualToString:@"Siri"])
		%init(SiriPrefHook, AssistantController = objc_getClass("AssistantController"));
}

%end

%end

%ctor
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    %init(PrefHook, PrefController = kCFCoreFoundationVersionNumber >= 793.00 ? objc_getClass("PSListController") : objc_getClass("PSRootController"));
    [pool drain];
}
