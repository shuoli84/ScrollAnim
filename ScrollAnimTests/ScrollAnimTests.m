#import "Kiwi.h"
#import "ScrollAnim.h"
#import "ScrollAnimEntry.h"

SPEC_BEGIN(ScrollAnimEntrySpec)

    describe(@"ScrollAnimEntry", ^{
        ScrollAnim * __block anim;
        UIImageView *__block imageView;

        beforeEach(^{
            imageView = [[UIImageView alloc] initWithImage:nil];

            anim = [[ScrollAnim alloc] init];
            [anim.animEntries addObjectsFromArray:@[
                [ScrollAnimEntry
                    entryWithObject:imageView
               keyPathValueSequence:@[
                   [KeyPathValueSequence
                       instanceWithKeyPath:@"center"
                                 valueType:AnimEntryValuePoint
                              offsetValues:@[
                                  MakeOV(400.f, [NSValue valueWithCGPoint:CGPointMake(100, 400)]),
                                  MakeOV(500.f, [NSValue valueWithCGPoint:CGPointMake(200, 350)]),
                                  MakeOV(600.f, [NSValue valueWithCGPoint:CGPointMake(300, 325)]),
                                  MakeOV(700.f, [NSValue valueWithCGPoint:CGPointMake(400, 300)]),
                                  MakeOV(800.f, [NSValue valueWithCGPoint:CGPointMake(500, 325)]),
                                  MakeOV(900.f, [NSValue valueWithCGPoint:CGPointMake(600, 350)]),
                                  MakeOV(1000.f, [NSValue valueWithCGPoint:CGPointMake(700, 400)]),
                              ]]
               ]
                ]
            ]];
        });

        it(@"Should able to caculate the right value", ^{
            [anim setContentOffset:0];
            [[NSStringFromCGPoint(imageView.center) should] equal:@"{100, 400}"];
            [anim setContentOffset:500];
            [[NSStringFromCGPoint(imageView.center) should] equal:@"{200, 350}"];

        });

    });

SPEC_END