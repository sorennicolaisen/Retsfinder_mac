#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 3) {
            fprintf(stderr, "Usage: icon_apply <icon.png> <app-path>\n");
            return 1;
        }

        NSString *iconPath = [NSString stringWithUTF8String:argv[1]];
        NSString *appPath = [NSString stringWithUTF8String:argv[2]];

        NSImage *icon = [[NSImage alloc] initWithContentsOfFile:iconPath];
        if (!icon) {
            fprintf(stderr, "Could not load icon image\n");
            return 2;
        }

        BOOL ok = [[NSWorkspace sharedWorkspace] setIcon:icon forFile:appPath options:0];
        if (!ok) {
            fprintf(stderr, "setIcon failed\n");
            return 3;
        }

        return 0;
    }
}
