//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//
//  SelectViewController.m
//  Katahira7
//
//  Created by 横山 マイケル on 09/02/11.
//  Copyright 2009 Mountainside. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

#import "Katahira.h"
#import "SelectViewController.h"

@implementation SelectViewController

-(IBAction)animateButtons:(id)sender
{
	[vcSelectButton1 setHidden:YES];
	[vcSelectButton2 setHidden:YES];
	[vcSelectButton3 setHidden:YES];
	[vcSelectButton4 setHidden:YES];
	[vcAnimateButton7 setHidden:NO];
	[vcAnimateButton7 setImage:gRightImage forState:0];
//	[self updateButtons];
}

-(void)initProcedure
{
	numDisplayed = 0;
	[vcAnimateButton7 setHidden:YES];
	[self updateButtons];
}

-(IBAction)vcSelectCenterPressed:(id)sender
{
	[self updateButtons];
}

-(IBAction)vcSelectButton1Pressed:(id)sender
{
	[self svPlayGuitarSound:vcSelectRightAnswer == 0?YES:NO];
	if (vcSelectRightAnswer == 0){
		[self animateButtons:sender];
	}
}

-(IBAction)vcSelectButton2Pressed:(id)sender
{
	[self svPlayGuitarSound:vcSelectRightAnswer == 1?YES:NO];
	if (vcSelectRightAnswer == 1){
		[self animateButtons:sender];
	}
}

-(IBAction)vcSelectButton3Pressed:(id)sender
{
	[self svPlayGuitarSound:vcSelectRightAnswer == 2?YES:NO];
	if (vcSelectRightAnswer == 2){ 
		[self animateButtons:sender];
	}
}

-(IBAction)vcSelectButton4Pressed:(id)sender
{
	[self svPlayGuitarSound:vcSelectRightAnswer == 3?YES:NO];
	if (vcSelectRightAnswer == 3){ 
		[self animateButtons:sender];
	}
}

-(IBAction)svPlayGuitarSound:(bool)correctness
{
	if (gSoundsAreOn == 1) {
		NSString *shortSoundPath;
		if (correctness == YES) {
			shortSoundPath = [[NSBundle mainBundle] pathForResource:@"RIGHT" ofType:@"aiff"]; 
		}
		else {
			shortSoundPath = [[NSBundle mainBundle] pathForResource:@"THATS WRONG" ofType:@"aiff"]; 
		}
		CFURLRef shortSoundURL = CFURLCreateWithFileSystemPath(0, (CFStringRef)shortSoundPath, kCFURLPOSIXPathStyle, NO); 
		AudioServicesCreateSystemSoundID(shortSoundURL, &shortSound);
		AudioServicesPlaySystemSound(shortSound);
		CFRelease(shortSoundURL);
	}
}

-(void)updateButtons
{
	[vcAnimateButton7 setHidden:YES];
	[vcSelectButton1 setHidden:NO];
	[vcSelectButton2 setHidden:NO];
	[vcSelectButton3 setHidden:NO];
	[vcSelectButton4 setHidden:NO];
		
	// Return values betwen 0 to hiraganaArrayMaxIndex in all of the following cases
	unsigned correctAnswer, answer2, answer3, answer4;

	// Find a random answer between 0 and hiraganaArrayMaxIndex
	// Check if the answer has been tested before (YES)
	// if all answers have been tested before, then initialize the array (set all to NO)
	// Note that the right answer will always be correctAnswer
	srandom(time(NULL));
	do {
		// Generate a right answer
		correctAnswer = random() % hiraganaArrayMaxIndex;
	} while (testedAnswersList[correctAnswer] == YES && numDisplayed < hiraganaArrayMaxIndex);
	testedAnswersList[correctAnswer] = YES;
	
	if (numDisplayed == hiraganaArrayMaxIndex) {
		// Initialize the array
		for (unsigned counter = 0; counter < hiraganaArrayMaxIndex; counter++) {
			testedAnswersList[counter] = NO;
		}
		
		// Generate a right answer
		correctAnswer = random() % hiraganaArrayMaxIndex;
	}
	do {
		answer2 = random() % hiraganaArrayMaxIndex;
	} while (correctAnswer == answer2);
	do {
		answer3 = random() % hiraganaArrayMaxIndex;	
	} while ((answer3 == correctAnswer) || (answer3 == answer2));
	do {
		answer4 = random() % hiraganaArrayMaxIndex;	
	}while ((answer4 == correctAnswer) || (answer4 == answer2) || (answer4 == answer3));
	
	gRightAnswer = correctAnswer;
	vcSelectLabel.text = [katahiraReadingsArray objectAtIndex:correctAnswer];
	testedAnswersList[correctAnswer] = YES;
	
	// Figure out a right box and put the images in the right locations
	srandom(time(NULL));
	vcSelectRightAnswer = random() % 4;
	
	UIImage *myImage1, *myImage2, *myImage3, *myImage4;
	myImage1 = [UIImage imageNamed:[hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:correctAnswer]];
	myImage2 = [UIImage imageNamed:[hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:answer2]];
	myImage3 = [UIImage imageNamed:[hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:answer3]];
	myImage4 = [UIImage imageNamed:[hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:answer4]];
	gRightImage = myImage1;

	switch (vcSelectRightAnswer) {
		case 0:
			break;
		case 1:
			myImage1 = [UIImage imageNamed:[hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:answer2]];
			myImage2 = [UIImage imageNamed:[hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:correctAnswer]];
			break;
		case 2:
			myImage1 = [UIImage imageNamed:[hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:answer3]];
			myImage3 = [UIImage imageNamed:[hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:correctAnswer]];
			break;
		case 3:
			myImage1 = [UIImage imageNamed:[hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:answer4]];
			myImage4 = [UIImage imageNamed:[hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:correctAnswer]];
			break;
		default:
			vcSelectLabel.text = @"Error";
			break;
	}
		
	[vcSelectButton1 setImage:myImage1 forState:0];
	[vcSelectButton2 setImage:myImage2 forState:0];
	[vcSelectButton3 setImage:myImage3 forState:0];
	[vcSelectButton4 setImage:myImage4 forState:0];
	numDisplayed++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
    [super dealloc];
}

@end