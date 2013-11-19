ScrollAnim
==========

A scroll animation library for iOS, which make cool animation based on scrollview's content offset

Amazed by an scroll animation from a web page? Now try this library, create scroll animation in iOS. Take a look 
at the example app, scroll down, and the sun will raise and set :)

Setup example
------------
    pod install
    
Install example
------------
Will create a podspec later.

Usage
------------
1. Create the ScrollAnim instance and hold a reference to it
   
        self.anim = [ScrollAnim.alloc init];

2. Create and add views as usual.
3. Create a scrollview and add it as a subview of self.view of the viewcontroller
    
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self.view addSubView:scrollView];

4. Assign the scroll view to anim instance
    
        self.anim.scrollView = scrollView;

5. Declare the animations as following
   
           // add anim entries, one entry stands for one view or animation unit
           [self.anim.animEntries addObjectsFromArray:@[
               [ScrollAnimEntry
                  entryWithObject:imageView
             // keyPathValueSequence is the mapping where maps the content offset to a value 
             keyPathValueSequence:@[
                      [KeyPathValueSequence
                          // keyPath used by KVO, valuetype must be consistent, then the array of offset value mappings
                          instanceWithKeyPath:@"center"
                                    valueType:AnimEntryValuePoint
                                 offsetValues:@[
                                     MakeOV(100.f, [NSValue valueWithCGPoint:CGPointMake(100, 400)]),
                                     MakeOV(200.f, [NSValue valueWithCGPoint:CGPointMake(200, 350)]),
                                     MakeOV(300.f, [NSValue valueWithCGPoint:CGPointMake(300, 325)]),
                                     MakeOV(400.f, [NSValue valueWithCGPoint:CGPointMake(400, 300)]),
                                     MakeOV(500.f, [NSValue valueWithCGPoint:CGPointMake(500, 325)]),
                                     MakeOV(600.f, [NSValue valueWithCGPoint:CGPointMake(600, 350)]),
                                     MakeOV(700.f, [NSValue valueWithCGPoint:CGPointMake(700, 400)]),
                                 ]]
                  ]
               ],
               [ScrollAnimEntry
               entryWithObject:skyView keyPathValueSequence:@[
                  [KeyPathValueSequence
                   instanceWithKeyPath:@"backgroundColor"
                   valueType:AnimEntryValueColor
                   offsetValues:@[
                                  MakeOV(100.f, [UIColor colorWithRed:10/255.f green:91/255.f blue:146/255.f alpha:1.f]),
                                  MakeOV(400.f, [UIColor colorWithRed:112/255.f green:198/255.f blue:255/255.f alpha:1.f]),
                                  MakeOV(700.f, [UIColor colorWithRed:255/255.f green:126/255.f blue:84/255.f alpha:1.f]),
                                  ]]
                  ]
               ]
          ]];
