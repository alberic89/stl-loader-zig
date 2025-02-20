const std = @import("std");
const stlLoader = @import("stl-loader");

pub fn main() !void {
    // path relative to cwd
    const filepath: []const u8 = "file.stl";

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const mesh = try stlLoader.loadStl(allocator, filepath);
    defer allocator.free(mesh);

    // read mesh
    for (mesh, 0..) |t, i| {
        std.debug.print("Triangle {d}:\n\t{d} {d} {d}\n", .{ i, t.v1.x, t.v1.y, t.v1.z });
        std.debug.print("\t{d} {d} {d}\n", .{ t.v2.x, t.v2.y, t.v2.z });
        std.debug.print("\t{d} {d} {d}\n", .{ t.v3.x, t.v3.y, t.v3.z });
    }
}
