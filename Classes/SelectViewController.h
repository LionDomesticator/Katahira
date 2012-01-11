//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//
//  SelectViewController.h
//  This is used for the 3rd Tab.
//  Katahira7
//
//  Created by 横山 マイケル on 09/02/11.
//  Copyright 2009 Mountainside. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

@interface SelectViewController : UIViewController {
    UITabBarController *tabBarController;
	SystemSoundID shortSound;
	NSTimer *timer;
	bool testedAnswersList[MAXNUMBEROFLETTERS];
	
	IBOutlet UILabel *vcSelectLabel;
	IBOutlet UIButton *vcSelectButton1;	
	IBOutlet UIButton *vcSelectButton2;
	IBOutlet UIButton *vcSelectButton3;
	IBOutlet UIButton *vcSelectButton4;
	IBOutlet UIButton *vcAnimateButton7;
	unsigned vcSelectRightAnswer;
}
-(IBAction)vcSelectCenterPressed:(id)sender;
-(IBAction)vcSelectButton1Pressed:(id)sender;
-(IBAction)vcSelectButton2Pressed:(id)sender;
-(IBAction)vcSelectButton3Pressed:(id)sender;
-(IBAction)vcSelectButton4Pressed:(id)sender;
-(void)initProcedure;
-(IBAction)animateButtons:(id)sender;
-(void)updateButtons;
-(IBAction)svPlayGuitarSound:(bool)correctness;
@end