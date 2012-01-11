//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//
//  KatahiraAppDelegate.m
//  Katahira
//
//  Created by myokoyama1 on 09/04/22.
//  Copyright Mountainside 2009. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


#import "KatahiraAppDelegate.h"

NSString *kHiraganaIsONKey	= @"hiragana_preference";
NSString *kSoundsAreONKey	= @"play_sounds_preference";

@implementation KatahiraAppDelegate

@synthesize window;
@synthesize tabBarController;

-(void)initProcedure
{
	if (showingAFirstTime == NO)
		[self updateButtons];
}

-(IBAction)kadNextButtonPressed:(id)sender
{
	[self updateButtons];
}

- (void)alertSimpleAction
{
	// open an alert with just an OK button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sounds are OFF" message:@"Set sounds ON in Settings Tab"
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];	
	[alert release];
}

-(IBAction)kadSayButtonPressed:(id)sender
{
	if (gSoundsAreOn == 1) {
        NSString *shortSoundPath = [[NSBundle mainBundle] pathForResource:readingsLabel.text ofType:@"aiff"]; 
		CFURLRef shortSoundURL = CFURLCreateWithFileSystemPath(0, (CFStringRef)shortSoundPath, kCFURLPOSIXPathStyle, NO); 
		AudioServicesCreateSystemSoundID(shortSoundURL, &shortSound);
		AudioServicesPlaySystemSound(shortSound);
		CFRelease(shortSoundURL);
	}
	else {
		[self alertSimpleAction];
	}
}

-(void)updateButtons
{
	UIImage *myImage;
	
	readingsLabel.text = (NSString*)[katahiraReadingsArray objectAtIndex:hIndexOfArray];
	
	NSString *my;
	my = [hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:hIndexOfArray];
	myImage = [UIImage imageNamed:my];
	[imageView setImage:myImage];
	
	hIndexOfArray++;
	
	hIndexOfArray = hIndexOfArray % hiraganaArrayMaxIndex;
}

-(void)tabBarController:(UITabBarController *)tbc didSelectViewController:(UIViewController *)viewController {
	NSUInteger currentlySelectedTabBarController = [tbc selectedIndex];
	switch (currentlySelectedTabBarController) {
		case 0:
			if (showingAFirstTime == YES) {
				showingAFirstTime = NO;
			}
			else {
                [self updateButtons];
			}
			break;
		case 1:
			[(SelectViewController*)viewController initProcedure];
			break;
		case 2:
			[(SelectViewController*)viewController initProcedure];
			break;
		default:
			break;
	}
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	settingsDataArray = [NSArray arrayWithObjects:
						 gHiraganaIsSelected?@"1":@"0",
						 gSoundsAreOn?@"1":@"0",
						 nil
						 ];
	[settingsDataArray writeToFile:@"SettingsData.txt" atomically:YES];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	
    // Override point for customization after application launch
	mainBundle = [NSBundle mainBundle];
	showingAFirstTime = YES;
	numDisplayed = 0;
	
	lPath = [mainBundle pathForResource: @"HiraganaFileNames" ofType: @"txt"];
	uPath = [mainBundle pathForResource: @"KatakanaFileNames" ofType: @"txt"];
	grPath = [mainBundle pathForResource: @"KatahiraReadings" ofType: @"txt"];
	
	hiraganafileRawContents = [NSString stringWithContentsOfFile:lPath
														 encoding:NSASCIIStringEncoding 
															error:NULL]; 
	hiraganaKatakanaArray[HIRAGANALETTER] = [[hiraganafileRawContents componentsSeparatedByString:@"\n"] retain]; 
	hiraganaArrayMaxIndex = [hiraganaKatakanaArray[HIRAGANALETTER] count] - 1;
	
	katakanafileRawContents = [NSString stringWithContentsOfFile:uPath
														 encoding:NSASCIIStringEncoding 
															error:NULL]; 
	hiraganaKatakanaArray[KATAKANALETTER] = [[katakanafileRawContents componentsSeparatedByString:@"\n"] retain]; 
	katakanaArrayMaxIndex = [hiraganaKatakanaArray[KATAKANALETTER] count] - 1;
	
	katahiraReadingsfileRawContents = [NSString stringWithContentsOfFile:grPath
															 encoding:NSASCIIStringEncoding 
																error:NULL]; 
	katahiraReadingsArray = [[katahiraReadingsfileRawContents componentsSeparatedByString:@"\n"] retain]; 
	katahiraReadingsArrayMaxIndex = [katahiraReadingsArray count] - 1;
	
	//////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////
	
	NSString *testValue = [[NSUserDefaults standardUserDefaults] stringForKey:kHiraganaIsONKey];
	if (testValue == nil)
	{
		// Since no default values have been set (i.e. no preferences file created), create it here
		NSDictionary *appDefaults =  [NSDictionary dictionaryWithObjectsAndKeys:
									  [NSNumber numberWithInt:1], kHiraganaIsONKey,
									  [NSNumber numberWithInt:1], kSoundsAreONKey,
									  nil];
		
		[[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	// Finally, set the key preference values
	gHiraganaIsSelected = [[NSUserDefaults standardUserDefaults] boolForKey:kHiraganaIsONKey];
	gSoundsAreOn = [[NSUserDefaults standardUserDefaults] boolForKey:kSoundsAreONKey];
	
	//////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////
	
	[window addSubview:tabBarController.view];
	[self updateButtons];
}

- (void)dealloc {
	[katahiraReadingsArray release];
	[settingsDataArray release];
    [window release];
    [super dealloc];
}

@end