//
//  JBViewController.m
//  Typeset
//
//  Created by YongbinZhang on 5/31/13.
//
//  Copyright (c) 2013 YongbinZhang
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


#import "JBViewController.h"


#ifndef TypesetMatrixViewTag
#define TypesetMatrixViewTag

#define TypesetMatrixViewTagLabelA  1101
#define TypesetMatrixViewTagLabelB  1102
#define TypesetMatrixViewTagMultilineLabelA 1111
#define TypesetMatrixViewTagMultilineLabelB 1121
#define TypesetMatrixViewTagImageViewA  1121
#define TypesetMatrixViewTagImageViewB  1122
#define TypesetMatrixViewTagTextViewA   1131
#define TypesetMatrixViewTagTextViewB   1132
#define TypesetMatrixViewTagCustomViewA 1141
#define TypesetMatrixViewTagCustomViewB 1142

#endif



@interface JBViewController ()

//  typeset board
@property (nonatomic, retain) JBTypesetBoardView *boardView;

//  typeset matrix(s)
@property (nonatomic, retain) JBTypesetMatrixView *matrixViewLabelA;
@property (nonatomic, retain) JBTypesetMatrixView *matrixViewLabelB;
@property (nonatomic, retain) JBTypesetMatrixView *matrixViewMultilineLabelA;
@property (nonatomic, retain) JBTypesetMatrixView *matrixViewMultilineLabelB;
@property (nonatomic, retain) JBTypesetMatrixView *matrixViewImageViewA;
@property (nonatomic, retain) JBTypesetMatrixView *matrixViewImageViewB;
@property (nonatomic, retain) JBTypesetMatrixView *matrixViewTextViewA;
@property (nonatomic, retain) JBTypesetMatrixView *matrixViewTextViewB;
@property (nonatomic, retain) JBTypesetMatrixView *matrixViewCustomViewA;
@property (nonatomic, retain) JBTypesetMatrixView *matrixViewCustomViewB;

//  initialize and set board and matrix(s)
- (void)prepareBoard;

//  clear board and matrix(s) settings
- (void)clearBoard;

//  show board and matrix(s) by view type
- (void)showBoardByViewType:(ViewType)viewType;

@end

@implementation JBViewController


#pragma mark -
#pragma mark - Class Methods
//  Singleton
+ (JBViewController *)defaultViewController
{
    static JBViewController *staticViewController = nil;
    if (!staticViewController) {
        staticViewController = [[JBViewController alloc] initWithNibName:nil bundle:nil];
    }
    
    return staticViewController;
}

#pragma mark -
#pragma mark - dealloc
- (void)dealloc
{
    [_matrixViewCustomViewA release];
    _matrixViewCustomViewA = nil;
    [_matrixViewCustomViewB release];
    _matrixViewCustomViewB = nil;
    [_matrixViewImageViewA release];
    _matrixViewImageViewA = nil;
    [_matrixViewImageViewB release];
    _matrixViewImageViewB = nil;
    [_matrixViewLabelA release];
    _matrixViewLabelA = nil;
    [_matrixViewLabelB release];
    _matrixViewLabelB = nil;
    [_matrixViewMultilineLabelA release];
    _matrixViewMultilineLabelA = nil;
    [_matrixViewMultilineLabelB release];
    _matrixViewMultilineLabelB = nil;
    [_matrixViewTextViewA release];
    _matrixViewTextViewA = nil;
    [_matrixViewTextViewB release];
    _matrixViewTextViewB = nil;
    
    [_boardView release];
    _boardView = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark -
#pragma mark - view did load
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
    //  initialize and set board and matrix(s)
    
    //  you can also put this methods into
    //  "- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil" method.
    
    //  In this version of Typeset, you should know which UI kits can be shown.
    //  And initialize the board and matrix(s) before showing them and set them.
    //  I think "Factory Method Pattern" is a good choice to resolve this issue.
    [self prepareBoard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - view will appear / disappear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //  show board and matrix(s) by view type
    [self showBoardByViewType:self.viewType];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


#pragma mark -
#pragma mark - view did appear / disappear
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{    
    [super viewDidDisappear:animated];
    
    //  clear board and matrix(s) settings
    //  board and matrix(s) will be setted to initial status
    
    //  *****************************************************
    //  In "Singleton Pattern", the viewController object will
    //  be used more than once times like this, So remember using
    //  "[self clearBoard]" to clear previous settings.
    //  *****************************************************
    [self clearBoard];
}



#pragma mark -
#pragma mark - Class Extensions
//  initialize and set board and matrix(s)
- (void)prepareBoard
{
    //  --------------setting board--------------
    BorderWidth *borderWidth = [[BorderWidth alloc] init];
    borderWidth.top = 5.0f;
    borderWidth.left = 10.0f;
    borderWidth.bottom = 5.0f;
    
    SeparationDistance *separationDistance = [[SeparationDistance alloc] init];
    separationDistance.portrait = 5.0f;
    
    
    self.boardView = [[JBTypesetBoardView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height) BorderWidth:borderWidth SeparationDistance:separationDistance LockWidth:YES LockHeight:NO];
    [self.view addSubview:self.boardView];
    
    
    //  --------------setting matrix(s)--------------
    //  matrixViewLabelA
    self.matrixViewLabelA = [[JBTypesetMatrixView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 30.0f)];
    self.matrixViewLabelA.matrixViewType = MatrixViewTypeLabel;
    self.matrixViewLabelA.flexibleViewDelegate = self.boardView;
    [self.matrixViewLabelA setStretchImage:[UIImage imageNamed:@"matrix_bg"] WithLeftCapWidth:50.0f TopCapHeight:10.0f];
    self.matrixViewLabelA.tag = TypesetMatrixViewTagLabelA;
    
    JBFlexibleLabel *lableA = (JBFlexibleLabel *)self.matrixViewLabelA.matrixView;
    lableA.backgroundColor = [UIColor clearColor];
    lableA.text = @"Label A";
    
    //  matrixViewLabelB
    self.matrixViewLabelB = [[JBTypesetMatrixView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 30.0f)];
    self.matrixViewLabelB.matrixViewType = MatrixViewTypeLabel;
    self.matrixViewLabelB.flexibleViewDelegate = self.boardView;
    [self.matrixViewLabelB setStretchImage:[UIImage imageNamed:@"matrix_bg"] WithLeftCapWidth:50.0f TopCapHeight:10.0f];
    self.matrixViewLabelB.tag = TypesetMatrixViewTagLabelB;
    
    JBFlexibleLabel *lableB = (JBFlexibleLabel *)self.matrixViewLabelB.matrixView;
    lableB.backgroundColor = [UIColor clearColor];
    lableB.text = @"Label B";

    //  matrixViewMultilineLabelA
    self.matrixViewMultilineLabelA = [[JBTypesetMatrixView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 30.0f)];
    self.matrixViewMultilineLabelA.matrixViewType = MatrixViewTypeMultilineLabel;
    self.matrixViewMultilineLabelA.flexibleViewDelegate = self.boardView;
    [self.matrixViewMultilineLabelA setStretchImage:[UIImage imageNamed:@"matrix_bg"] WithLeftCapWidth:50.0f TopCapHeight:10.0f];
    self.matrixViewMultilineLabelA.tag = TypesetMatrixViewTagMultilineLabelA;
    
    JBFlexibleMultilineLabel *multilineA = (JBFlexibleMultilineLabel *)self.matrixViewMultilineLabelA.matrixView;
    multilineA.backgroundColor = [UIColor clearColor];
    multilineA.text = @"Typeset is a simple tool to develop dynamic UI, that some UI kits is just determinated after application is running. But you should know all these UI kits could be shown, and initialize and set them before showing.";
    
    //  matrixViewMultilineLabelB
    self.matrixViewMultilineLabelB = [[JBTypesetMatrixView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 30.0f)];
    self.matrixViewMultilineLabelB.matrixViewType = MatrixViewTypeMultilineLabel;
    self.matrixViewMultilineLabelB.flexibleViewDelegate = self.boardView;
    [self.matrixViewMultilineLabelB setStretchImage:[UIImage imageNamed:@"matrix_bg"] WithLeftCapWidth:50.0f TopCapHeight:10.0f];
    self.matrixViewMultilineLabelB.tag = TypesetMatrixViewTagMultilineLabelB;
    
    JBFlexibleMultilineLabel *multilineB = (JBFlexibleMultilineLabel *)self.matrixViewMultilineLabelB.matrixView;
    multilineB.backgroundColor = [UIColor clearColor];
    multilineB.text = @"Typeset is a simple tool to develop dynamic UI, that some UI kits is just determinated after application is running. But you should know all these UI kits could be shown, and initialize and set them before showing.";
    
    
    //  matrixViewImageViewA
    self.matrixViewImageViewA = [[JBTypesetMatrixView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 200.0f)];
    self.matrixViewImageViewA.matrixViewType = MatrixViewTypeImageView;
    self.matrixViewImageViewA.flexibleViewDelegate = self.boardView;
    self.matrixViewImageViewA.tag = TypesetMatrixViewTagImageViewA;
    
    JBFlexibleImageView *imageViewA = (JBFlexibleImageView *)self.matrixViewImageViewA.matrixView;
    imageViewA.image = [UIImage imageNamed:@"imageA"];
    
    //  matrixViewImageViewB
    self.matrixViewImageViewB = [[JBTypesetMatrixView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 200.0f)];
    self.matrixViewImageViewB.matrixViewType = MatrixViewTypeImageView;
    self.matrixViewImageViewB.flexibleViewDelegate = self.boardView;
    self.matrixViewImageViewB.tag = TypesetMatrixViewTagImageViewB;
    
    JBFlexibleImageView *imageViewB = (JBFlexibleImageView *)self.matrixViewImageViewB.matrixView;
    imageViewB.image = [UIImage imageNamed:@"imageB"];
    
    
    //  matrixViewTextViewA
    self.matrixViewTextViewA = [[JBTypesetMatrixView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 50.0f)];
    self.matrixViewTextViewA.matrixViewType = MatrixViewTypeTextView;
    self.matrixViewTextViewA.flexibleViewDelegate = self.boardView;
    [self.matrixViewTextViewA setStretchImage:[UIImage imageNamed:@"matrix_bg"] WithLeftCapWidth:50.0f TopCapHeight:10.0f];
    self.matrixViewTextViewA.tag = TypesetMatrixViewTagTextViewA;
    
    JBFlexibleTextView *textViewA = (JBFlexibleTextView *)self.matrixViewTextViewA.matrixView;
    textViewA.text = @"Typeset is a simple tool to develop dynamic UI, that some UI kits is just determinated after application is running. But you should know all these UI kits could be shown, and initialize and set them before showing.";
    
    //  matrixViewTextViewB
    self.matrixViewTextViewB = [[JBTypesetMatrixView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 50.0f)];
    self.matrixViewTextViewB.matrixViewType = MatrixViewTypeTextView;
    self.matrixViewTextViewB.flexibleViewDelegate = self.boardView;
    [self.matrixViewTextViewB setStretchImage:[UIImage imageNamed:@"matrix_bg"] WithLeftCapWidth:50.0f TopCapHeight:10.0f];
    self.matrixViewTextViewB.tag = TypesetMatrixViewTagTextViewB;
    
    JBFlexibleTextView *textViewB = (JBFlexibleTextView *)self.matrixViewTextViewB.matrixView;
    textViewB.text = @"Typeset is a simple tool to develop dynamic UI, that some UI kits is just determinated after application is running. But you should know all these UI kits could be shown, and initialize and set them before showing.";
    
    
    //  matrixViewCustomViewA
    self.matrixViewCustomViewA = [[JBTypesetMatrixView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 50.0f)];
    self.matrixViewCustomViewA.matrixViewType = MatrixViewTypeCustomView;
    self.matrixViewCustomViewA.flexibleViewDelegate = self.boardView;
    [self.matrixViewCustomViewA setStretchImage:[UIImage imageNamed:@"matrix_bg"] WithLeftCapWidth:50.0f TopCapHeight:10.0f];
    self.matrixViewCustomViewA.tag = TypesetMatrixViewTagCustomViewA;
    
    UIView *customViewA = (JBFlexibleView *)self.matrixViewCustomViewA.matrixView;
    UIButton *buttonA = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [customViewA addSubview:buttonA];
    
    
    //  matrixViewCustomViewB
    self.matrixViewCustomViewB = [[JBTypesetMatrixView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 50.0f)];
    self.matrixViewCustomViewB.matrixViewType = MatrixViewTypeCustomView;
    self.matrixViewCustomViewB.flexibleViewDelegate = self.boardView;
    [self.matrixViewCustomViewB setStretchImage:[UIImage imageNamed:@"matrix_bg"] WithLeftCapWidth:50.0f TopCapHeight:10.0f];
    self.matrixViewCustomViewB.tag = TypesetMatrixViewTagCustomViewB;
    
    UIView *customViewB = (JBFlexibleView *)self.matrixViewCustomViewB.matrixView;
    UIButton *buttonB = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [customViewB addSubview:buttonB];
}


//  clean board and matrix(s) settings
- (void)clearBoard
{
    [self.boardView removeAllMatrixs];
}

//  show board and matrix(s) by view type
- (void)showBoardByViewType:(ViewType)viewType
{
    switch (viewType) {
        case ViewTypeA:
        {
            [self.boardView insertMatrixViewAtFirst:self.matrixViewLabelA];
            [self.boardView insertMatrixView:self.matrixViewImageViewA AfterMatrixViewWithTag:TypesetMatrixViewTagLabelA];
            [self.boardView insertMatrixView:self.matrixViewCustomViewA AfterMatrixViewWithTag:TypesetMatrixViewTagImageViewA];
            [self.boardView insertMatrixView:self.matrixViewMultilineLabelA AfterMatrixViewWithTag:TypesetMatrixViewTagCustomViewA];
            [self.boardView insertMatrixView:self.matrixViewTextViewA AfterMatrixViewWithTag:TypesetMatrixViewTagMultilineLabelA];
            
            break;
        }
            
        case ViewTypeB:
        {
            [self.boardView insertMatrixViewAtFirst:self.matrixViewLabelB];
            [self.boardView insertMatrixViewAtFirst:self.matrixViewTextViewB];
            [self.boardView insertMatrixViewAtFirst:self.matrixViewCustomViewB];
            [self.boardView insertMatrixViewAtFirst:self.matrixViewMultilineLabelB];
            [self.boardView insertMatrixViewAtFirst:self.matrixViewImageViewB];
            
            break;
        }
            
        case ViewTypeC:
        {
            [self.boardView insertMatrixViewAtFirst:self.matrixViewMultilineLabelA];
            [self.boardView insertMatrixView:self.matrixViewMultilineLabelB BeforeMatrixView:self.matrixViewMultilineLabelA];
            [self.boardView insertMatrixViewAtLast:self.matrixViewImageViewB];
            [self.boardView insertMatrixViewAtLast:self.matrixViewCustomViewB];
            
            break;
        }
            
        default:
        {
            break;
        }
    }
}

@end
