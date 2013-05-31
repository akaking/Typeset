//
//  JBTypesetBoardView.m
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

#import "JBTypesetBoardView.h"


#ifndef InvalidIndex
#define InvalidIndex    UINTMAX_MAX
#endif

#ifndef InvalidPoint
#define InvalidPoint    CGPointMake(InvalidIndex, InvalidIndex)
#endif

@interface JBTypesetBoardView ()

@property (nonatomic, assign) CGRect tmpFrame;

//  border of the board edge
@property (nonatomic, assign, readwrite) BorderWidth *borderWidth;

//  separation between matrixs
@property (nonatomic, assign, readwrite) SeparationDistance *separationDistance;

//  whether the width of board is locked
@property (nonatomic, assign, readwrite) BOOL lockWidth;
//  whether the height of board is locked
@property (nonatomic, assign, readwrite) BOOL lockHeight;

//  matrixs in the board
@property (nonatomic, retain, readwrite) NSMutableArray *matrixViews;

//  matrix's position that will be inserted into board at last
@property (nonatomic, assign) CGFloat positionYForMatrixViewAtLast;
@property (nonatomic, assign) CGFloat positionXForMatrixViewAtLast;


//  the first matrix
- (UIView <FlexibleViewDelegate> *)firstMatrixView;
//  the last matrix
- (UIView <FlexibleViewDelegate> *)lastMatrixView;

//  matrix at index
- (UIView <FlexibleViewDelegate> *)matrixViewAtIndex:(NSInteger)index;
//  matrix before index
- (UIView <FlexibleViewDelegate> *)matrixViewBeforeIndex:(NSInteger)index;
//  matrix before other matrix
- (UIView <FlexibleViewDelegate> *)matrixViewBeforeOtherMatrixView:(UIView <FlexibleViewDelegate> *)otherMatrixView;
//  matrix with a separater tag
- (UIView <FlexibleViewDelegate> *)matrixViewWithTag:(NSInteger)tag;

//  index of matrix
- (NSInteger)indexOfMatrixView:(UIView <FlexibleViewDelegate> *)matrixView;
//  index of matrix with a separater tag
- (NSInteger)indexOfMatrixViewWithTag:(NSInteger)tag;

//  move all matrixs after matrix at index down with size
- (void)movePositionDownOfMatrixViewsFromIndex:(NSInteger)index WithSize:(CGSize)size;
//  move all matrixs after matrix at index up with size
- (void)movePositionUpOfMatrixViewsFromIndex:(NSInteger)index WithSize:(CGSize)size;

//  origin of matrix at index
- (CGPoint)originOfMatrixViewAtIndex:(NSInteger)index;
//  insert matrix at position
- (void)insertMatrixView:(UIView <FlexibleViewDelegate> *)matrixView AtPosition:(CGPoint)position;

//  change matrix's size by old size and new size
- (void)changeSizeOfMatrixView:(UIView <FlexibleViewDelegate> *)matrixView WithOldSize:(CGSize)oldSize NewSize:(CGSize)newSize;

@end




@implementation JBTypesetBoardView

@synthesize flexibleViewDelegate = _flexibleViewDelegate;

@synthesize borderWidth = _borderWidth;
@synthesize separationDistance = _separationDistance;

@synthesize lockWidth = _lockWidth;
@synthesize lockHeight = _lockHeight;

@synthesize matrixViews = _matrixViews;

@synthesize positionYForMatrixViewAtLast = _positionYForMatrixViewAtLast;
@synthesize positionXForMatrixViewAtLast = _positionXForMatrixViewAtLast;

#pragma mark -
#pragma mark - dealloc and init
- (void)dealloc
{
    [_matrixViews release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tmpFrame = self.frame;
        
        [self observeViewFrameChanging:YES];

        self.borderWidth = [[BorderWidth alloc] init];
        self.separationDistance = [[SeparationDistance alloc] init];
        
        self.lockHeight = NO;
        self.lockWidth = YES;
        
        self.matrixViews = [[NSMutableArray alloc] init];
    }
    return self;
}

//  init method
//  frame:the frame of board
//  borderWidth:set border of the board edge
//  separationDistace:set separation between matrixs
//  lockWidth:lock the width of board or not
//  lockHeight:lock the height of board or not
- (id)initWithFrame:(CGRect)frame BorderWidth:(BorderWidth *)borderWidth SeparationDistance:(SeparationDistance *)separationDistance LockWidth:(BOOL)lockWidth LockHeight:(BOOL)lockHeight
{
    self = [self initWithFrame:frame];
    if (self) {
        if (borderWidth) {
            self.borderWidth.top = borderWidth.top;
            self.borderWidth.left = borderWidth.left;
            self.borderWidth.bottom = borderWidth.bottom;
            self.borderWidth.right = borderWidth.right;
        }
        
        if (separationDistance) {
            self.separationDistance.landscape = separationDistance.landscape;
            self.separationDistance.portrait = separationDistance.portrait;
        }
        
        self.lockWidth = lockWidth;
        self.lockHeight = lockHeight;
        
        self.positionYForMatrixViewAtLast = self.borderWidth.top;
        self.positionXForMatrixViewAtLast = self.borderWidth.left;
        
        if (!self.lockHeight) {
            self.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height + 1.0f);
        }
    }
    
    return self;
}


#pragma mark -
#pragma mark - Class Extensions
//  the first matrix
- (UIView <FlexibleViewDelegate> *)firstMatrixView
{
    if (self.matrixViews.count > 0) {
        return [self.matrixViews objectAtIndex:0];
    } else {
        return nil;
    }
}

//  the last matrix
- (UIView <FlexibleViewDelegate> *)lastMatrixView
{
    if (self.matrixViews.count > 0) {
        return [self.matrixViews objectAtIndex:(self.matrixViews.count - 1)];
    } else {
        return nil;
    }
}

//  matrix at index
- (UIView <FlexibleViewDelegate> *)matrixViewAtIndex:(NSInteger)index
{
    if (index >= 0 && index < self.matrixViews.count) {
        return [self.matrixViews objectAtIndex:index];
    } else {
        return nil;
    }
}

//  matrix before index
- (UIView <FlexibleViewDelegate> *)matrixViewBeforeIndex:(NSInteger)index
{
    if (index >= 0 && self.matrixViews.count > index) {
        return [self.matrixViews objectAtIndex:(index - 1)];
    } else {
        return nil;
    }
}

//  matrix before other matrix
- (UIView <FlexibleViewDelegate> *)matrixViewBeforeOtherMatrixView:(UIView <FlexibleViewDelegate> *)otherMatrixView
{
    for (NSInteger i = 0; i < self.matrixViews.count; i++) {
        UIView <FlexibleViewDelegate> *matrixView = [self.matrixViews objectAtIndex:i];
        if ([matrixView isEqual:otherMatrixView]) {
            if (i == 0) {
                return nil;
            } else {
                return [self.matrixViews objectAtIndex:(i - 1)];
            }
        }
    }
    
    return nil;
}

//  matrix with a separater tag
- (UIView <FlexibleViewDelegate> *)matrixViewWithTag:(NSInteger)tag
{
    for (UIView <FlexibleViewDelegate> *matrixView in self.matrixViews) {
        if (matrixView.tag == tag) {
            return matrixView;
        }
    }
    
    return nil;
}


//  index of matrix
- (NSInteger)indexOfMatrixView:(UIView <FlexibleViewDelegate> *)matrixView
{
    if (matrixView) {
        for (NSInteger i = 0; i < self.matrixViews.count; i++) {
            UIView <FlexibleViewDelegate> *subView = [self.matrixViews objectAtIndex:i];
            if ([subView isEqual:matrixView]) {
                return i;
            }
        }
    }
    
    return (NSInteger)InvalidIndex;
}

//  index of matrix with a separater tag
- (NSInteger)indexOfMatrixViewWithTag:(NSInteger)tag
{
    for (NSInteger i = 0; i < self.matrixViews.count; i++) {
        UIView <FlexibleViewDelegate> *subView = [self.matrixViews objectAtIndex:i];
        if (subView.tag == tag) {
            return i;
        }
    }
    
    return (NSInteger)InvalidIndex;
}

//  move all matrixs after matrix at index down with size
- (void)movePositionDownOfMatrixViewsFromIndex:(NSInteger)index WithSize:(CGSize)size
{
    if (index >= 0 && index <= self.matrixViews.count) {
        for (NSInteger i = (self.matrixViews.count - 1); i >= 0 && i >= index && self.matrixViews.count > 0; i--) {            
            UIView <FlexibleViewDelegate> *matrixView = [self.matrixViews objectAtIndex:i];
            CGRect tmpFrame = matrixView.frame;
            tmpFrame.origin.y += size.height;
            matrixView.frame = tmpFrame;
        }
        self.positionYForMatrixViewAtLast += size.height;
        
        if (!self.lockHeight) {
            if (self.positionYForMatrixViewAtLast + self.borderWidth.bottom > self.bounds.size.height) {
                self.contentSize = CGSizeMake(self.contentSize.width, self.positionYForMatrixViewAtLast + self.borderWidth.bottom);
            }
        } else {
            if (self.positionYForMatrixViewAtLast + self.borderWidth.bottom > self.frame.size.height) {
                self.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.positionYForMatrixViewAtLast + self.borderWidth.bottom);
            }
        }
    }
}


//  move all matrixs after matrix at index up with size
- (void)movePositionUpOfMatrixViewsFromIndex:(NSInteger)index WithSize:(CGSize)size
{    
    if (index >= 0 && index < self.matrixViews.count) {
        for (NSInteger i = index; i < self.matrixViews.count && self.matrixViews.count > 0; i++) {
            UIView <FlexibleViewDelegate> *matrixView = [self.matrixViews objectAtIndex:i];
            CGRect tmpFrame = matrixView.frame;
            tmpFrame.origin.y -= size.height;
            matrixView.frame = tmpFrame;
        }
        
        self.positionYForMatrixViewAtLast -= size.height;
        
        if (!self.lockHeight) {
            if (self.positionYForMatrixViewAtLast + self.borderWidth.bottom > self.bounds.size.height) {
                self.contentSize = CGSizeMake(self.contentSize.width, self.positionYForMatrixViewAtLast + self.borderWidth.bottom);
            }
        } else {
            if (self.positionYForMatrixViewAtLast + self.borderWidth.bottom < self.frame.size.height) {
                self.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.positionYForMatrixViewAtLast + self.borderWidth.bottom);
            }
        }
    }
}


//  origin of matrix at index
- (CGPoint)originOfMatrixViewAtIndex:(NSInteger)index
{
    if (index >= 0 && index <= self.matrixViews.count) {
        if (index == 0) {
            return CGPointMake(self.borderWidth.left, self.borderWidth.top);
        } else {
            if (index == self.matrixViews.count) {
                return CGPointMake(self.positionXForMatrixViewAtLast, self.positionYForMatrixViewAtLast);
            } else {
                UIView <FlexibleViewDelegate> *matrixView = [self matrixViewAtIndex:index];
                if (matrixView) {
                    return matrixView.frame.origin;
                } else {
                    return InvalidPoint;
                }
            }
        }
    } else {
        return CGPointMake(self.positionXForMatrixViewAtLast, self.positionYForMatrixViewAtLast);
    }
}

//  insert matrix at position
- (void)insertMatrixView:(UIView <FlexibleViewDelegate> *)matrixView AtPosition:(CGPoint)position
{
    if (matrixView) {
        CGRect tmpMatrixViewFrame = matrixView.frame;
        tmpMatrixViewFrame.origin = position;
        matrixView.frame = tmpMatrixViewFrame;
        
        [self addSubview:matrixView];
    }
}


//  change matrix's size by old size and new size
- (void)changeSizeOfMatrixView:(UIView <FlexibleViewDelegate> *)matrixView WithOldSize:(CGSize)oldSize NewSize:(CGSize)newSize
{
    if (oldSize.height != newSize.height) {
        NSInteger tmpIndex = [self indexOfMatrixView:matrixView];
        if (tmpIndex != InvalidIndex) {
            if (oldSize.height < newSize.height) {
                [self movePositionDownOfMatrixViewsFromIndex:(tmpIndex + 1) WithSize:CGSizeMake(0.0f, newSize.height - oldSize.height)];
            } else {
                [self movePositionUpOfMatrixViewsFromIndex:(tmpIndex + 1) WithSize:CGSizeMake(0.0f, oldSize.height - newSize.height)];
            }
        }
    } else if (oldSize.width != newSize.width) {
        
    }
}


#pragma mark -
#pragma mark - Object Methods
//  clear setting to initial status
- (void)clearSettings
{
    self.frame = self.tmpFrame;
    
    self.positionYForMatrixViewAtLast = self.borderWidth.top;
    self.positionXForMatrixViewAtLast = self.borderWidth.left;
    
    if (!self.lockHeight) {
        self.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height + 1.0f);
    }
}


//  -------------insert Matrix--------------

//  insert matrix at the frist of board
- (void)insertMatrixViewAtFirst:(UIView <FlexibleViewDelegate> *)matrixView
{
    if (matrixView) {
        [self insertMatrixView:matrixView AtIndex:0];
    }
}

//  insert matrix at the last of board
- (void)insertMatrixViewAtLast:(UIView <FlexibleViewDelegate> *)matrixView
{
    if (matrixView) {        
        [self insertMatrixView:matrixView AtIndex:self.matrixViews.count];
    }
}


//  insert matrix at a separate index(insert at the last of board if index is too big)
- (void)insertMatrixView:(UIView <FlexibleViewDelegate> *)matrixView AtIndex:(NSInteger)index
{
    if (matrixView &&  index >= 0 && index != InvalidIndex) {
        //  insert matrix at position
        [self insertMatrixView:matrixView AtPosition:[self originOfMatrixViewAtIndex:index]];
        
        //  move matrixs after index down
        [self movePositionDownOfMatrixViewsFromIndex:index WithSize:CGSizeMake(matrixView.frame.size.width, matrixView.frame.size.height + self.separationDistance.portrait)];
        
        [self.matrixViews insertObject:matrixView atIndex:index];
    }
}

//  insert matrix before other matrix
- (void)insertMatrixView:(UIView <FlexibleViewDelegate> *)matrixView BeforeMatrixView:(UIView <FlexibleViewDelegate> *)otherMatrixView
{
    if (matrixView && otherMatrixView) {
        [self insertMatrixView:matrixView AtIndex:[self indexOfMatrixView:otherMatrixView]];
    }
}

//  insert matrix after other matrix
- (void)insertMatrixView:(UIView<FlexibleViewDelegate> *)matrixView AfterMatrixView:(UIView<FlexibleViewDelegate> *)otherMatrixView
{
    if (matrixView && otherMatrixView) {
        [self insertMatrixView:matrixView AtIndex:([self indexOfMatrixView:otherMatrixView] + 1)];
    }
}

//  insert matrix before matrix with a separate tag
- (void)insertMatrixView:(UIView <FlexibleViewDelegate> *)matrixView BeforeMatrixViewWithTag:(NSInteger)otherMatrixViewTag
{
    [self insertMatrixView:matrixView BeforeMatrixView:[self matrixViewWithTag:otherMatrixViewTag]];
}

//  insert matrix after matrix with a separate tag
- (void)insertMatrixView:(UIView <FlexibleViewDelegate> *)matrixView AfterMatrixViewWithTag:(NSInteger)otherMatrixViewTag
{
    [self insertMatrixView:matrixView AfterMatrixView:[self matrixViewWithTag:otherMatrixViewTag]];
}




//  ------------remove matrix-------------

//  remove matrix
- (void)removeMatrixView:(UIView <FlexibleViewDelegate> *)matrixView
{
    if (matrixView) {
        [self removeMatrixAtIndex:[self indexOfMatrixView:matrixView]];
    }
}

//  remove matrix at index
- (void)removeMatrixAtIndex:(NSInteger)index
{    
    if (index >= 0 && index != InvalidIndex && index < self.matrixViews.count) {        
        if (index < self.matrixViews.count) {
            UIView <FlexibleViewDelegate> *matrixView = [self.matrixViews objectAtIndex:index];
            CGRect tmpRect = matrixView.frame;
            
            [self movePositionUpOfMatrixViewsFromIndex:index WithSize:CGSizeMake(tmpRect.size.width, tmpRect.size.height + self.separationDistance.portrait)];
            
            //matrixView.hidden = YES;
            [matrixView removeFromSuperview];
            
            if ([matrixView respondsToSelector:@selector(clearSettings)]) {
                [matrixView performSelector:@selector(clearSettings)];
            }
            
            [self.matrixViews removeObjectAtIndex:index];
        }
    }
}

//  remove matrix by matrix's tag
- (void)removeMatrixByMatrixViewTag:(NSInteger)matrixViewTag
{
    [self removeMatrixAtIndex:[self indexOfMatrixViewWithTag:matrixViewTag]];
}

//  remove the first matrix
- (void)removeFirstMatrixView
{
    if (self.matrixViews.count > 0) {
        [self removeMatrixAtIndex:0];
    }
}

//  remove the last matrix
- (void)removeLastMatrixView
{
    if (self.matrixViews.count > 0) {
        [self removeMatrixAtIndex:(self.matrixViews.count - 1)];
    }
}

//  remove matrix before other matrix
- (void)removeMatrixViewBeforeMatrixView:(UIView <FlexibleViewDelegate> *)otherMatrixView
{
    if (self.matrixViews.count > 0) {
        NSInteger tmpIndex = [self indexOfMatrixView:otherMatrixView];
        if (tmpIndex != InvalidIndex) {
            if (tmpIndex > 0) {
                [self removeMatrixAtIndex:(tmpIndex - 1)];
            }
        }
    }
}

//  remove matrix after other matrix
- (void)removeMatrixViewAfterMatrixView:(UIView<FlexibleViewDelegate> *)otherMatrixView
{
    if (self.matrixViews.count > 0) {
        NSInteger tmpIndex = [self indexOfMatrixView:otherMatrixView];
        if (tmpIndex != InvalidIndex) {
            if ((tmpIndex + 1) < self.matrixViews.count) {
                [self removeMatrixAtIndex:(tmpIndex + 1)];
            }
        }
    }
}

//  remove matrix before other matrix with a separate tag
- (void)removeMatrixViewBeforeMatrixViewWithTag:(NSInteger)otherMatrixViewTag
{
    if (self.matrixViews.count > 0) {
        NSInteger tmpIndex = [self indexOfMatrixViewWithTag:otherMatrixViewTag];
        if (tmpIndex != InvalidIndex) {
            if (tmpIndex > 0) {
                [self removeMatrixAtIndex:(tmpIndex - 1)];
            }
        }
    }
}

//  remove matrix after other matrix whth a separate tag
- (void)removeMatrixViewAfterMatrixViewWithTag:(NSInteger)otherMatrixViewTag
{
    if (self.matrixViews.count > 0) {
        NSInteger tmpIndex = [self indexOfMatrixViewWithTag:otherMatrixViewTag];
        if (tmpIndex != InvalidIndex) {
            if ((tmpIndex + 1) < self.matrixViews.count) {
                [self removeMatrixAtIndex:(tmpIndex + 1)];
            }
        }
    }
}

//  remove all matrixs
- (void)removeAllMatrixs
{
    for (UIView <FlexibleViewDelegate> *matrixView in self.matrixViews) {
        [matrixView removeFromSuperview];
    }
    
    
    for (UIView <FlexibleViewDelegate> *matrixView in self.matrixViews) {
        if ([matrixView respondsToSelector:@selector(clearSettings)]) {
            [matrixView performSelector:@selector(clearSettings)];
        }
    }
    [self.matrixViews removeAllObjects];
    
    if ([self respondsToSelector:@selector(clearSettings)]) {
        [self performSelector:@selector(clearSettings)];
    }
}



#pragma mark -
#pragma mark - FlexibleViewDelegate
- (void)viewFrameChangedWithOldFrame:(CGRect)oldFrame NewFrame:(CGRect)newFrame
{
    if ([self.flexibleViewDelegate respondsToSelector:@selector(flexibleView:FrameChangedWithOldFrame:NewFrame:)]) {
        [self.flexibleViewDelegate flexibleView:self FrameChangedWithOldFrame:oldFrame NewFrame:newFrame];
    }
}

#pragma mark -
#pragma mark - JBTypesetBoardDelegate
- (void)flexibleView:(UIView<FlexibleViewDelegate> *)flexibleView FrameChangedWithOldFrame:(CGRect)oldFrame NewFrame:(CGRect)newFrame
{    
    if (flexibleView) {
        for (UIView <FlexibleViewDelegate> *matrixView in self.matrixViews) {
            if ([matrixView isEqual:flexibleView]) {
                [self changeSizeOfMatrixView:matrixView WithOldSize:oldFrame.size NewSize:newFrame.size];
                
                break;
            }
        }
    }
}


@end







#ifndef DefaultBorderWidth
#define DefaultBorderWidth
#define DefaultBorderWidthT 5.0f
#define DefaultBorderWidthL 10.0f
#define DefaultBorderWidthB 10.0f
#define DefaultBorderWidthR 10.0f
#endif


@implementation BorderWidth

@synthesize top = _top;
@synthesize left = _left;
@synthesize bottom = _bottom;
@synthesize right = _right;


#pragma mark -
#pragma mark - dealloc and init

- (void)dealloc
{
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.top = DefaultBorderWidthT;
        self.left = DefaultBorderWidthL;
        self.bottom = DefaultBorderWidthB;
        self.right = DefaultBorderWidthR;
    }
    
    return self;
}

@end






#ifndef DefaultSeparationDistance
#define DefaultSeparationDistance
#define DefaultSeparationDistanceOfLandscape    10.0f
#define DefaultSeparationDistanceOfPortrait     10.0f
#endif

@implementation SeparationDistance

@synthesize landscape = _landscape;
@synthesize portrait = _portrait;

#pragma mark -
#pragma mark - dealloc and init
- (void)dealloc
{
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.landscape = DefaultSeparationDistanceOfLandscape;
        self.portrait = DefaultSeparationDistanceOfPortrait;
    }
    
    return self;
}

@end
