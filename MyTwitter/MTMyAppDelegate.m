

#import "MTMyAppDelegate.h"
#import "MTAppDelegate.h"

@implementation MTMyAppDelegate

-(BOOL)openURL:(NSURL *)url{

    MTAppDelegate* del =(MTAppDelegate *) [[UIApplication sharedApplication] delegate];
    return [del openURL:url];
}

@end