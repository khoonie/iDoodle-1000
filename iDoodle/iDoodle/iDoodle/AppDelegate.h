//
//  AppDelegate.h
//  iDoodle
//
//  Created by BMM Mac on 2011/6/13.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "doodleLayer.h"

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate, sliderDelegate> {
    IBOutlet UIWindow			*window;
    IBOutlet RootViewController	*viewController;
    IBOutlet UIView             *myView;
    IBOutlet UISlider           *mySlider;
    id  node;
}
-(void)setupSlider;
-(IBAction) sliderErase:(id)sender;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *viewController;
@property (nonatomic, retain) IBOutlet UIView *myView;
@property (nonatomic, retain) IBOutlet UISlider *mySlider;
@end
