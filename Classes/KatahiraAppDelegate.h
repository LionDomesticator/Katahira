//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//
//  KatahiraAppDelegate.h
//  Katahira
//
//  Created by myokoyama1 on 09/04/22.
//  Copyright Mountainside 2009. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

#import "Katahira.h"
#import "IdentifyViewController.h"
#import "SelectViewController.h"
#import "SettingsViewController.h"

@interface KatahiraAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	IBOutlet UIImageView *imageView;
	IBOutlet UILabel *readingsLabel;
	bool showingAFirstTime;
	
	SystemSoundID shortSound; 
	IBOutlet UIButton *kadSayButton;
	IBOutlet UIButton *kadNextButton;
}
-(void)alertSimpleAction;
-(IBAction)kadSayButtonPressed:(id)sender;
-(IBAction)kadNextButtonPressed:(id)sender;
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
-(void)initProcedure;
-(void)updateButtons;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property(nonatomic, readonly, retain) IBOutlet UITabBarController *tabBarController;
@end