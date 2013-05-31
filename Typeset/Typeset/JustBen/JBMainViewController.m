//
//  JBMainViewController.m
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

#import "JBMainViewController.h"

#import "JBViewController.h"


@interface JBMainViewController ()

@property (nonatomic, retain) UIButton *typeAButton;
- (void)actionForTypeAButton:(id)typeAButton;

@property (nonatomic, retain) UIButton *typeBButton;
- (void)actionForTypeBButton:(id)typeBButton;

@property (nonatomic, retain) UIButton *typeCButton;
- (void)actionForTypeCButton:(id)typeCButton;

@end

@implementation JBMainViewController

#pragma mark -
#pragma mark - dealloc
- (void)dealloc
{
    [_typeAButton release];
    _typeAButton = nil;
    [_typeBButton release];
    _typeBButton = nil;
    [_typeCButton release];
    _typeCButton = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Main View Controller";
    }
    return self;
}


#pragma mark -
#pragma mark - view did load
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.typeAButton = [[UIButton alloc] initWithFrame:CGRectMake(85.0f, 10.0f, 150.0f, 30.0f)];
    [self.typeAButton setBackgroundImage:[UIImage imageNamed:@"typeButton_bg"] forState:UIControlStateNormal];
    [self.typeAButton setTitle:@"Type A" forState:UIControlStateNormal];
    [self.typeAButton addTarget:self action:@selector(actionForTypeAButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.typeAButton];
    
    self.typeBButton = [[UIButton alloc] initWithFrame:CGRectMake(85.0f, 50.0f, 150.0f, 30.0f)];
    [self.typeBButton setBackgroundImage:[UIImage imageNamed:@"typeButton_bg"] forState:UIControlStateNormal];
    [self.typeBButton setTitle:@"Type B" forState:UIControlStateNormal];
    [self.typeBButton addTarget:self action:@selector(actionForTypeBButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.typeBButton];
    
    self.typeCButton = [[UIButton alloc] initWithFrame:CGRectMake(85.0f, 90.0f, 150.0f, 30.0f)];
    [self.typeCButton setBackgroundImage:[UIImage imageNamed:@"typeButton_bg"] forState:UIControlStateNormal];
    [self.typeCButton setTitle:@"Type C" forState:UIControlStateNormal];
    [self.typeCButton addTarget:self action:@selector(actionForTypeCButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.typeCButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - Class Extensions
- (void)actionForTypeAButton:(id)typeAButton
{
    [JBViewController defaultViewController].viewType = ViewTypeA;
    [JBViewController defaultViewController].title = @"View Type A";
    [self.navigationController pushViewController:[JBViewController defaultViewController] animated:YES];
}

- (void)actionForTypeBButton:(id)typeBButton
{
    [JBViewController defaultViewController].viewType = ViewTypeB;
    [JBViewController defaultViewController].title = @"View Type B";
    [self.navigationController pushViewController:[JBViewController defaultViewController] animated:YES];
}

- (void)actionForTypeCButton:(id)typeCButton
{
    [JBViewController defaultViewController].viewType = ViewTypeC;
    [JBViewController defaultViewController].title = @"View Type C";
    [self.navigationController pushViewController:[JBViewController defaultViewController] animated:YES];
}

@end
