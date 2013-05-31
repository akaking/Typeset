//
//  JBFlexibleTableView.m
//  sxrc
//
//  Created by YongbinZhang on 4/18/13.
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

#import "JBFlexibleTableView.h"


@interface JBFlexibleTableView ()

@property (nonatomic, assign) CGRect tmpFrame;

@end

@implementation JBFlexibleTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tmpFrame = self.frame;
        [self observeViewFrameChanging:YES];

    }
    return self;
}


#pragma mark -
#pragma mark - Object Methods
//  clear setting to initial status
- (void)clearSettings
{
    self.frame = self.tmpFrame;
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
