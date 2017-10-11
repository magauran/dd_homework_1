//
//  ViewController.m
//  Calculator
//
//  Created by Алексей on 04.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()
@property(strong, nonatomic) Calculator *calculator;
@end

@implementation ViewController

@synthesize calculator = _calculator;

NSString* currentNumber = @"";

- (Calculator *)calculator {
    if (!_calculator) {
        _calculator = [[Calculator alloc] init];
    }
    return _calculator;
}

- (IBAction)appendDigit:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    [self updateDisplay:digit];
    currentNumber = [currentNumber stringByAppendingString:digit];
}

- (IBAction)operate:(UIButton *)sender {
    double myDouble = [currentNumber doubleValue];
    if (myDouble) {
        [self.calculator pushOperand:myDouble];
    }
    currentNumber = @"";
    NSString* operation = [sender currentTitle];
    [self.calculator pushOperation:operation];
    [self updateDisplay:operation];
}

- (IBAction)calculate {
    double myDouble = [currentNumber doubleValue];
    [self.calculator pushOperand:myDouble];
    self.outDisplay.text = self.inDisplay.text;
    double res = [self.calculator performOperation];
    
    NSNumber *myDoubleNumber = [NSNumber numberWithDouble:res];
    self.inDisplay.text = [myDoubleNumber stringValue];
    
    [self.calculator clearProgramStack];
    currentNumber = [[NSNumber numberWithDouble:res] stringValue];
}

- (void)updateDisplay:(NSString *)valueToDisplay {
    if ([self.inDisplay.text  isEqual: @"0"]) {
        self.inDisplay.text = valueToDisplay;
    } else {
        self.inDisplay.text = [self.inDisplay.text stringByAppendingString: valueToDisplay];
    }
}

- (IBAction)clean {
    currentNumber = @"";
    [self.calculator clearProgramStack];
    self.inDisplay.text = @"0";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end