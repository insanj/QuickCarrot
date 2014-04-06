#import <libactivator/libactivator.h>
#import <UIKit/UIKit.h>

@interface QuickCarrot : NSObject <LAListener, UIAlertViewDelegate> {
@private
	UIAlertView *taskView;
}
@end

@implementation QuickCarrot

-(BOOL)dismiss{
	if (taskView) {
		[taskView dismissWithClickedButtonIndex:[taskView cancelButtonIndex] animated:YES];
		[taskView release];
		taskView = nil;
		return YES;
	}//end if

	return NO;
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
	[taskView release];
	taskView = nil;

	if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Create"]){
		NSString *str = [@"carrot://addTask?" stringByAppendingString:[alertView textFieldAtIndex:0].text];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	}//end if
}

-(void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event{

	if (![self dismiss]) {
		if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"carrot:"]]){
			taskView = [[UIAlertView alloc] initWithTitle:@"QuickCarrot" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create", nil];
			[taskView setAlertViewStyle:UIAlertViewStylePlainTextInput];
			[[taskView textFieldAtIndex:0] setPlaceholder:@"New CARROT Task"];
		}//end if

		else
			taskView = [[UIAlertView alloc] initWithTitle:@"CARROT Required" message:@"Please install CARROT for iOS from the App Store to use QuickCarrot!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];

		[taskView show];
		[event setHandled:YES];
	}//end if
}

-(void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event{
	[self dismiss];
}

-(void)activator:(LAActivator *)activator otherListenerDidHandleEvent:(LAEvent *)event{
	[self dismiss];
}

-(void)activator:(LAActivator *)activator receiveDeactivateEvent:(LAEvent *)event{
	if ([self dismiss])
		[event setHandled:YES];
}

-(void)dealloc{
	[taskView release];
	[super dealloc];
}

+(void)load{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"libactivator.quickcarrot"];
	[pool release];
}

@end 