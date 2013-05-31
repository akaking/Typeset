//
//  JBTypesetBoardView.h
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


#import "UIView+Flexible.h"
#import "JBFlexibleViewDelegate.h"



@class BorderWidth;
@class SeparationDistance;
@interface JBTypesetBoardView : UIScrollView <JBFlexibleViewDelegate>

@property (nonatomic, assign) id <JBFlexibleViewDelegate> flexibleViewDelegate;

//  border of the board edge
@property (nonatomic, assign, readonly) BorderWidth *borderWidth;
//  separation between matrixs
@property (nonatomic, assign, readonly) SeparationDistance *separationDistance;

//  whether the width of board is locked
@property (nonatomic, assign, readonly) BOOL lockWidth;
//  whether the height of board is locked
@property (nonatomic, assign, readonly) BOOL lockHeight;

//  matrixs in the board
@property (nonatomic, retain, readonly) NSMutableArray *matrixViews;



//  init method
//  frame:the frame of board
//  borderWidth:set border of the board edge
//  separationDistace:set separation between matrixs
//  lockWidth:lock the width of board or not
//  lockHeight:lock the height of board or not
- (id)initWithFrame:(CGRect)frame BorderWidth:(BorderWidth *)borderWidth SeparationDistance:(SeparationDistance *)separationDistance LockWidth:(BOOL)lockWidth LockHeight:(BOOL)lockHeight;

//  clear setting to initial status
- (void)clearSettings;


//  -------------insert Matrix--------------

//  insert matrix at the frist of board
- (void)insertMatrixViewAtFirst:(UIView <FlexibleViewDelegate> *)matrixView;
//  insert matrix at the last of board
- (void)insertMatrixViewAtLast:(UIView <FlexibleViewDelegate> *)matrixView;

//  insert matrix at a separate index(insert at the last of board if index is too big)
- (void)insertMatrixView:(UIView <FlexibleViewDelegate> *)matrixView AtIndex:(NSInteger)index;

//  insert matrix before other matrix
- (void)insertMatrixView:(UIView <FlexibleViewDelegate> *)matrixView BeforeMatrixView:(UIView <FlexibleViewDelegate> *)otherMatrixView;
//  insert matrix after other matrix
- (void)insertMatrixView:(UIView<FlexibleViewDelegate> *)matrixView AfterMatrixView:(UIView<FlexibleViewDelegate> *)otherMatrixView;

//  insert matrix before matrix with a separate tag
- (void)insertMatrixView:(UIView <FlexibleViewDelegate> *)matrixView BeforeMatrixViewWithTag:(NSInteger)otherMatrixViewTag;
//  insert matrix after matrix with a separate tag
- (void)insertMatrixView:(UIView <FlexibleViewDelegate> *)matrixView AfterMatrixViewWithTag:(NSInteger)otherMatrixViewTag;




//  ------------remove matrix-------------

//  remove matrix
- (void)removeMatrixView:(UIView <FlexibleViewDelegate> *)matrixView;
//  remove matrix at index
- (void)removeMatrixAtIndex:(NSInteger)index;
//  remove matrix by matrix's tag
- (void)removeMatrixByMatrixViewTag:(NSInteger)matrixViewTag;

//  remove the first matrix
- (void)removeFirstMatrixView;
//  remove the last matrix
- (void)removeLastMatrixView;

//  remove matrix before other matrix
- (void)removeMatrixViewBeforeMatrixView:(UIView <FlexibleViewDelegate> *)otherMatrixView;
//  remove matrix after other matrix
- (void)removeMatrixViewAfterMatrixView:(UIView<FlexibleViewDelegate> *)otherMatrixView;

//  remove matrix before other matrix with a separate tag
- (void)removeMatrixViewBeforeMatrixViewWithTag:(NSInteger)otherMatrixViewTag;
//  remove matrix after other matrix whth a separate tag
- (void)removeMatrixViewAfterMatrixViewWithTag:(NSInteger)otherMatrixViewTag;


//  remove all matrixs
- (void)removeAllMatrixs;

@end






@interface BorderWidth : NSObject

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

@end


@interface SeparationDistance : NSObject

@property (nonatomic, assign) CGFloat landscape;
@property (nonatomic, assign) CGFloat portrait;

@end
