//
//  JBTypesetMatrixView.m
//  sxrc
//
//  Created by YongbinZhang on 4/10/13.
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

#import "JBTypesetMatrixView.h"


@interface JBTypesetMatrixView ()

@property (nonatomic, assign) CGRect tmpFrame;

@end

@implementation JBTypesetMatrixView

#pragma mark -
#pragma mark - dealloc
- (void)dealloc
{
    [_matrixView release];
    _matrixView = nil;
    
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
        
        [self observeViewFrameChanging:YES];

        self.minHeight = self.frame.size.height;
    }
    return self;
}


#pragma mark -
#pragma mark - Object Methods
//  clear setting to initial status
- (void)clearSettings
{
    if ([self.matrixView respondsToSelector:@selector(clearSettings)]) {
        [self.matrixView performSelector:@selector(clearSettings)];
    }
    
    self.frame = self.tmpFrame;
}


#pragma mark -
#pragma mark - Setter
- (void)setMatrixViewType:(MatrixViewType)matrixViewType
{
    _matrixViewType = matrixViewType;
    
    switch (_matrixViewType) {
        case MatrixViewTypeInvalid:
        {
            if (self.matrixView) {
                [self.matrixView removeFromSuperview];
                [self.matrixView release];
                self.matrixView = nil;
            }
            
            break;
        }
            
        case MatrixViewTypeCustomView:
        {
            if (self.matrixView) {
                [self.matrixView removeFromSuperview];
                [self.matrixView release];
            }
            
            JBFlexibleView *flexibleView = [[JBFlexibleView alloc] initWithFrame:self.bounds];
            flexibleView.flexibleViewDelegate = self;
            self.matrixView = flexibleView;
            
            break;
        }
            
        case MatrixViewTypeLabel:
        {
            if (self.matrixView) {
                [self.matrixView removeFromSuperview];
                [self.matrixView release];
            }
            
            JBFlexibleLabel *label = [[JBFlexibleLabel alloc] initWithFrame:self.bounds];
            label.flexibleViewDelegate = self;
            self.matrixView = label;
            [label release];
                        
            break;
        }
            
        case MatrixViewTypeMultilineLabel:
        {
            if (self.matrixView) {
                [self.matrixView removeFromSuperview];
                [self.matrixView release];
            }
            
            JBFlexibleMultilineLabel *label = [[JBFlexibleMultilineLabel alloc] initWithFrame:self.bounds];
            label.flexibleViewDelegate = self;
            label.numberOfLines = 0;
            self.matrixView = label;
            [label release];
            
            break;
        }
            
        case MatrixViewTypeButton:
        {
            if (self.matrixView) {
                [self.matrixView removeFromSuperview];
                [self.matrixView release];
            }
            
            JBFlexibleButton *button = [[JBFlexibleButton alloc] initWithFrame:self.bounds];
            button.flexibleViewDelegate = self;
            self.matrixView = button;
            [button release];
            
            break;
        }
            
        case MatrixViewTypePlainTable:
        {
            if (self.matrixView) {
                [self.matrixView removeFromSuperview];
                [self.matrixView release];
            }
            
            JBFlexibleTableView *tableView = [[JBFlexibleTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
            tableView.flexibleViewDelegate = self;
            self.matrixView = tableView;
            [tableView release];
        
            break;
        }
            
        case MatrixViewTypeGroupedTable:
        {
            if (self.matrixView) {
                [self.matrixView removeFromSuperview];
                [self.matrixView release];
            }
            
            JBFlexibleTableView *tableView = [[JBFlexibleTableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
            tableView.flexibleViewDelegate = self;
            self.matrixView = tableView;
            [tableView release];
            
            break;
        }
            
        case MatrixViewTypeTextField:
        {
            if (self.matrixView) {
                [self.matrixView removeFromSuperview];
                [self.matrixView release];
            }
            
            JBFlexibleTextField *textField = [[JBFlexibleTextField alloc] initWithFrame:self.bounds];
            textField.flexibleViewDelegate = self;
            self.matrixView = textField;
            [textField release];
            
            break;
        }
            
        case MatrixViewTypeTextView:
        {
            if (self.matrixView) {
                [self.matrixView removeFromSuperview];
                [self.matrixView release];
            }
            
            JBFlexibleTextView *textView = [[JBFlexibleTextView alloc] initWithFrame:self.bounds];
            textView.flexibleViewDelegate = self;
            self.matrixView = textView;
            [textView release];
            
            break;
        }
            
        case MatrixViewTypeImageView:
        {
            if (self.matrixView) {
                [self.matrixView removeFromSuperview];
                [self.matrixView release];
            }
            
            JBFlexibleImageView *imageView = [[JBFlexibleImageView alloc] initWithFrame:self.bounds];
            imageView.flexibleViewDelegate = self;
            self.matrixView = imageView;
            [imageView release];
            
            break;
        }
            
        case MatrixViewTypeBoard:
        {
            if (self.matrixView) {
                [self.matrixView removeFromSuperview];
                [self.matrixView release];
            }
            
            JBTypesetBoardView *boardView = [[JBTypesetBoardView alloc] initWithFrame:self.bounds];
            boardView.flexibleViewDelegate = self;
            self.matrixView = boardView;
            [boardView release];
            
            break;
        }

            
        default:
            break;
    }
    
    if (self.matrixView) {
        [self addSubview:self.matrixView];
    }
}


- (void)setMatrixView:(UIView *)matrixView
{
    if (matrixView && ![matrixView isEqual:_matrixView]) {
        if (_matrixView) {
            [_matrixView removeFromSuperview];
            [_matrixView release];
        }
        
        _matrixView = [matrixView retain];
        [self addSubview:_matrixView];
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


#pragma mark -
#pragma mark - JBFlexibleViewDelegate
- (void)flexibleView:(UIView<FlexibleViewDelegate> *)flexibleView FrameChangedWithOldFrame:(CGRect)oldFrame NewFrame:(CGRect)newFrame
{    
    if ([flexibleView isEqual:self.matrixView]) {
        CGFloat offsetH = newFrame.size.height - oldFrame.size.height;
        
        CGRect tmpRect = self.frame;
        
        if (self.minHeight <= (tmpRect.size.height + offsetH)) {
            tmpRect.size.height += offsetH;
            self.frame = tmpRect;
        }
        
        for (UIView *subView in self.subviews) {
            if (subView.tag == BgImageViewTag) {
                UIImageView *bgImageView = (UIImageView *)subView;
                bgImageView.frame = self.bounds;
            }
        }
    }
}


@end
