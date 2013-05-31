//
//  JBFlexibleMultilineLabel.m
//  sxrc
//
//  Created by YongbinZhang on 4/19/13.
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

#import "JBFlexibleMultilineLabel.h"

@interface JBFlexibleMultilineLabel ()

@property (nonatomic, assign) CGFloat expectedHeight;

@property (nonatomic, assign) CGRect tmpFrame;


@property (nonatomic, retain) UITapGestureRecognizer *tapGR;
- (void)actionForTapGR;
@property (nonatomic, assign) BOOL isShowingAllText;

@end

@implementation JBFlexibleMultilineLabel

#pragma mark -
#pragma mark - dealloc
- (void)dealloc
{    
    [super dealloc];
}


#pragma mark -
#pragma mark - init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tmpFrame = self.frame;
        self.minHeight = self.frame.size.height;

        self.isShowingAllText = NO;
        
        [self setUserInteractionEnabled:YES];
        [self observeViewFrameChanging:YES];

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
        self.lineBreakMode = UILineBreakModeWordWrap;
#else
        self.lineBreakMode = NSLineBreakByWordWrapping;;
#endif
        self.numberOfLines = 0;
        self.userInteractionEnabled = YES;
        self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForTapGR)];
        [self addGestureRecognizer:self.tapGR];
    }
    return self;
}


#pragma mark -
#pragma mark - Setter
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self sizeToFit];
    
    CGRect tmpFrame = self.frame;
    self.frame = tmpFrame;
    
    self.frame = self.tmpFrame;
}


#pragma mark -
#pragma mark - Object Methods
- (void)showAllText
{    
    [self sizeToFit];
    
    CGRect tmpFrame = self.frame;
    if (self.frame.size.height > self.minHeight) {
        self.frame = tmpFrame;
    } else {
        self.frame = self.tmpFrame;
    }
}


- (void)showIntroText
{
    if (self.frame.size.height > self.minHeight) {
        self.frame = self.tmpFrame;
    }
}

//  clear setting to initial status
- (void)clearSettings
{
    [self showIntroText];
    self.isShowingAllText = NO;
    
    self.frame = self.tmpFrame;
}


#pragma mark -
#pragma mark - Class Extensions
- (void)actionForTapGR
{
    if (self.isShowingAllText) {
        self.isShowingAllText = NO;
        
        [self showIntroText];
    } else {
        self.isShowingAllText = YES;
        
        [self showAllText];
    }
}


#pragma mark -
#pragma mark - FlexibleViewDelegate
- (void)viewFrameChangedWithOldFrame:(CGRect)oldFrame NewFrame:(CGRect)newFrame
{
    if (!CGSizeEqualToSize(oldFrame.size, newFrame.size)) {
        if ([self.flexibleViewDelegate respondsToSelector:@selector(flexibleView:FrameChangedWithOldFrame:NewFrame:)]) {
            [self.flexibleViewDelegate flexibleView:self FrameChangedWithOldFrame:oldFrame NewFrame:newFrame];
        }
    }
}

@end
