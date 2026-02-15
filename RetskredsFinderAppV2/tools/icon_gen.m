#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 2) {
            fprintf(stderr, "Usage: icon_gen <output.png>\n");
            return 1;
        }

        NSString *outPath = [NSString stringWithUTF8String:argv[1]];
        CGFloat size = 1024.0;
        NSImage *image = [[NSImage alloc] initWithSize:NSMakeSize(size, size)];

        [image lockFocus];

        NSRect rect = NSMakeRect(0, 0, size, size);
        NSBezierPath *rounded = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(rect, 36, 36) xRadius:220 yRadius:220];

        NSGradient *bg = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.05 green:0.14 blue:0.34 alpha:1.0]
                                                       endingColor:[NSColor colorWithCalibratedRed:0.09 green:0.37 blue:0.72 alpha:1.0]];
        [bg drawInBezierPath:rounded angle:90.0];

        [[NSColor colorWithCalibratedWhite:1 alpha:0.16] setStroke];
        [rounded setLineWidth:10.0];
        [rounded stroke];

        NSBezierPath *pill = [NSBezierPath bezierPathWithRoundedRect:NSMakeRect(132, 112, 760, 186) xRadius:94 yRadius:94];
        [[NSColor colorWithCalibratedWhite:1 alpha:0.14] setFill];
        [pill fill];

        NSDictionary *titleAttrs = @{
            NSFontAttributeName: [NSFont boldSystemFontOfSize:108],
            NSForegroundColorAttributeName: [NSColor whiteColor]
        };
        [@"RF" drawAtPoint:NSMakePoint(430, 160) withAttributes:titleAttrs];

        NSColor *ivory = [NSColor colorWithCalibratedRed:0.98 green:0.96 blue:0.90 alpha:1.0];

        NSBezierPath *roof = [NSBezierPath bezierPath];
        [roof moveToPoint:NSMakePoint(230, 420)];
        [roof lineToPoint:NSMakePoint(512, 250)];
        [roof lineToPoint:NSMakePoint(794, 420)];
        [roof closePath];
        [ivory setFill];
        [roof fill];

        NSBezierPath *beam = [NSBezierPath bezierPathWithRoundedRect:NSMakeRect(238, 420, 548, 42) xRadius:10 yRadius:10];
        [beam fill];

        NSArray<NSNumber *> *xs = @[@285, @390, @495, @600, @705];
        for (NSNumber *x in xs) {
            NSBezierPath *col = [NSBezierPath bezierPathWithRoundedRect:NSMakeRect(x.doubleValue, 460, 52, 260) xRadius:18 yRadius:18];
            [col fill];
        }

        NSBezierPath *base = [NSBezierPath bezierPathWithRoundedRect:NSMakeRect(230, 730, 564, 48) xRadius:12 yRadius:12];
        [base fill];

        NSBezierPath *lens = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(650, 560, 220, 220)];
        [[NSColor colorWithCalibratedRed:1 green:0.78 blue:0.18 alpha:1.0] setStroke];
        [lens setLineWidth:28.0];
        [lens stroke];

        NSBezierPath *handle = [NSBezierPath bezierPath];
        [handle moveToPoint:NSMakePoint(804, 732)];
        [handle lineToPoint:NSMakePoint(910, 848)];
        [handle setLineWidth:34.0];
        [handle setLineCapStyle:NSLineCapStyleRound];
        [handle stroke];

        [image unlockFocus];

        NSBitmapImageRep *rep = [[NSBitmapImageRep alloc] initWithData:[image TIFFRepresentation]];
        NSData *png = [rep representationUsingType:NSBitmapImageFileTypePNG properties:@{}];
        if (![png writeToFile:outPath atomically:YES]) {
            fprintf(stderr, "Failed writing PNG\n");
            return 2;
        }
    }

    return 0;
}
