//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//
//  IdentifyViewController.m
//  Katahira7
//
//  Created by 横山 マイケル on 09/02/11.
//  Copyright 2009 Mountainside. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

#import "IdentifyViewController.h"

@implementation IdentifyViewController

-(void)initProcedure
{
	numDisplayed = 0;
	[vcAnimateButton7 setHidden:YES];
	[self updateButtons];
}

-(IBAction)vcCenterButtonPressed:(id)sender
{
	[self updateButtons];
}

-(IBAction)animateButtons:(id)sender
{
	[vcIdentifyButton1 setHidden:YES];
	[vcIdentifyButton2 setHidden:YES];
	[vcIdentifyButton3 setHidden:YES];
	[vcIdentifyButton4 setHidden:YES];
	[vcAnimateButton7 setHidden:NO];
	[vcAnimateButton7 setTitle:[katahiraReadingsArray objectAtIndex:gRightAnswer] forState:0];
}

-(IBAction)ivPlayGuitarSound:(bool)correctness
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

-(IBAction)vcIdentifyButton1Pressed:(id)sender
{
	[self ivPlayGuitarSound:(vcIdentifyRightAnswer == 0?YES:NO)];
	if (vcIdentifyRightAnswer == 0){
		[self animateButtons:sender];
	}
}

-(IBAction)vcIdentifyButton2Pressed:(id)sender
{
	[self ivPlayGuitarSound:(vcIdentifyRightAnswer == 1?YES:NO)];
	if (vcIdentifyRightAnswer == 1){
		[self animateButtons:sender];
	}
}

-(IBAction)vcIdentifyButton3Pressed:(id)sender
{
	[self ivPlayGuitarSound:(vcIdentifyRightAnswer == 2?YES:NO)];
	if (vcIdentifyRightAnswer == 2){
		[self animateButtons:sender];
	}
}

-(IBAction)vcIdentifyButton4Pressed:(id)sender
{
	[self ivPlayGuitarSound:(vcIdentifyRightAnswer == 3?YES:NO)];
	if (vcIdentifyRightAnswer == 3){
		[self animateButtons:sender];
	}
}

-(void)updateButtons
{
	[vcAnimateButton7 setHidden:YES];
	[vcIdentifyButton1 setHidden:NO];
	[vcIdentifyButton2 setHidden:NO];
	[vcIdentifyButton3 setHidden:NO];
	[vcIdentifyButton4 setHidden:NO];
	
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
	} while ((answer4 == correctAnswer) || (answer4 == answer2) || (answer4 == answer3));
	gRightAnswer = correctAnswer;

	UIImage *tempImage = [UIImage imageNamed:[hiraganaKatakanaArray[gHiraganaIsSelected?NO:YES] objectAtIndex:correctAnswer]];
	[imageView setImage:tempImage];
	
	// Figure out a right box and put the text answers in the right locations
	[vcIdentifyButton1 setTitle:[katahiraReadingsArray objectAtIndex:correctAnswer] forState:0];
	[vcIdentifyButton2 setTitle:[katahiraReadingsArray objectAtIndex:answer2] forState:0];
	[vcIdentifyButton3 setTitle:[katahiraReadingsArray objectAtIndex:answer3] forState:0];
	[vcIdentifyButton4 setTitle:[katahiraReadingsArray objectAtIndex:answer4] forState:0];
	vcIdentifyRightAnswer = random() % 4;
	switch (vcIdentifyRightAnswer) {
		case 1:
			[vcIdentifyButton1 setTitle:[katahiraReadingsArray objectAtIndex:answer2] forState:0];
			[vcIdentifyButton2 setTitle:[katahiraReadingsArray objectAtIndex:correctAnswer] forState:0];
			break;
		case 2:
			[vcIdentifyButton1 setTitle:[katahiraReadingsArray objectAtIndex:answer3] forState:0];
			[vcIdentifyButton3 setTitle:[katahiraReadingsArray objectAtIndex:correctAnswer] forState:0];
			break;
		case 3:
			[vcIdentifyButton1 setTitle:[katahiraReadingsArray objectAtIndex:answer4] forState:0];
			[vcIdentifyButton4 setTitle:[katahiraReadingsArray objectAtIndex:correctAnswer] forState:0];
			break;
		case 0:
		default:
			break;
	}
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