const std = @import("std");

pub fn buildSFMLSystem(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const sfml_system_lib = b.addStaticLibrary(.{
        .name = "sfml-system",
        .target = target,
        .optimize = optimize,
    });

    sfml_system_lib.addIncludePath(.{ .path = "include" });
    sfml_system_lib.addIncludePath(.{ .path = "src" });
    sfml_system_lib.addIncludePath(.{ .path = "extlibs/headers" });

    sfml_system_lib.addCSourceFiles(.{
        .files = &generic_system_src_files,
    });

    sfml_system_lib.linkLibC();
    sfml_system_lib.linkLibCpp();

    sfml_system_lib.installHeadersDirectory("include", "sfml-system");
    sfml_system_lib.installHeadersDirectory("src", "sfml-system");
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const t = target.result;

    const sfml_system_lib = b.addStaticLibrary(.{
        .name = "sfml",
        .target = target,
        .optimize = optimize,
    });

    sfml_system_lib.addIncludePath(.{ .path = "include" });
    sfml_system_lib.addIncludePath(.{ .path = "src" });
    sfml_system_lib.addIncludePath(.{ .path = "extlibs/headers" });

    sfml_system_lib.addCSourceFiles(.{
        .files = &generic_system_src_files,
    });

    sfml_system_lib.linkLibC();
    sfml_system_lib.linkLibCpp();

    switch (t.os.tag) {
        .windows => {
            sfml_system_lib.addCSourceFiles(.{
                .files = &windows_system_src_files,
            });
        },
        .macos => {

        },
        else => {

        },
    }

    sfml_system_lib.installHeadersDirectory("extlibs", "extlibs");
    sfml_system_lib.installHeadersDirectory("include", "include");
    sfml_system_lib.installHeadersDirectory("src", "src");

    b.installArtifact(sfml_system_lib);
}

pub fn buildOLD(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    // const t = target.result;s
    const lib = b.addStaticLibrary(.{
        .name = "sfml",
        .target = target,
        .optimize = optimize,
    });
    lib.addIncludePath(.{ .path = "include" });
    lib.addIncludePath(.{ .path = "src" });
    lib.addIncludePath(.{ .path = "extlibs/headers" });
    // lib.addIncludePath(.{ .path = "extlibs/headers/glad/include" });
    // lib.addIncludePath(.{ .path = "extlibs/headers/stb_image" });
    // lib.addIncludePath(.{ .path = "extlibs/headers/freetype2" });
    // lib.addIncludePath(.{ .path = "extlibs/headers/ogg" });
    // lib.addIncludePath(.{ .path = "extlibs/headers/vorbis" });
    // lib.addIncludePath(.{ .path = "extlibs/headers/miniaudio" });
    // lib.addIncludePath(.{ .path = "extlibs/headers/FLAC" });

    const config_values = .{
        .DEBUG = 1,
    };

    lib.addConfigHeader(b.addConfigHeader(.{
        .style = .blank,
    }, config_values));

    // lib.addCSourceFiles(.{
    //     .files = &graphics_src_files,
    // });
    lib.addCSourceFiles(.{
        .files = &generic_system_src_files,
    });
    // lib.addCSourceFiles(.{
    //     .files = &window_src_files,
    // });
    // lib.addCSourceFiles(.{
    //     .files = &network_src_files,
    // });
    // lib.addCSourceFiles(.{
    //     .files = &audio_src_files,
    // });

    lib.linkLibC();
    lib.linkLibCpp();
    lib.installHeadersDirectory("include", "SFML");
    lib.installHeadersDirectory("src", "SFML");
    lib.installHeadersDirectory("extlibs/headers/glad/include", "sfml/extlibs/headers/glad/include/glad");
    lib.installHeadersDirectory("extlibs/headers/stb_image", "sfml/extlibs/headers/stb_image");
    lib.installHeadersDirectory("extlibs/headers/freetype2", "sfml/extlibs/headers/freetype2");
    lib.installHeadersDirectory("extlibs/headers/ogg", "sfml/extlibs/headers/ogg");
    lib.installHeadersDirectory("extlibs/headers/vorbis", "sfml/extlibs/headers/vorbis");
    lib.installHeadersDirectory("extlibs/headers/miniaudio", "sfml/extlibs/headers/miniaudio");
    lib.installHeadersDirectory("extlibs/headers/FLAC", "sfml/extlibs/headers/FLAC");
    b.installArtifact(lib);
}

const audio_src_files = [_][]const u8{
    "src/SFML/Audio/AudioDevice.cpp",
    // "src/SFML/Audio/AudioResource.cpp",
    // "src/SFML/Audio/InputSoundFile.cpp",
    // "src/SFML/Audio/Listener.cpp",
    // "src/SFML/Audio/Miniaudio.cpp",
    // "src/SFML/Audio/MiniaudioUtils.cpp",
    // "src/SFML/Audio/Music.cpp",
    // "src/SFML/Audio/OutputSoundFile.cpp",
    // "src/SFML/Audio/Sound.cpp",
    // "src/SFML/Audio/SoundBuffer.cpp",
    // "src/SFML/Audio/SoundBufferRecorder.cpp",
    // "src/SFML/Audio/SoundFileFactory.cpp",
    // "src/SFML/Audio/SoundFileReaderFlac.cpp",
    // "src/SFML/Audio/SoundFileReaderMp3.cpp",
    // "src/SFML/Audio/SoundFileReaderOgg.cpp",
    // "src/SFML/Audio/SoundFileReaderWav.cpp",
    // "src/SFML/Audio/SoundFileWriterFlac.cpp",
    // "src/SFML/Audio/SoundFileWriterOgg.cpp",
    // "src/SFML/Audio/SoundFileWriterWav.cpp",
    // "src/SFML/Audio/SoundRecorder.cpp",
    // "src/SFML/Audio/SoundSource.cpp",
    // "src/SFML/Audio/SoundStream.cpp",
};

const window_src_files = [_][]const u8{
    "src/SFML/Window/Clipboard.cpp",
    "src/SFML/Window/Context.cpp",
    "src/SFML/Window/Cursor.cpp",
    "src/SFML/Window/EGLCheck.cpp",
    "src/SFML/Window/EglContext.cpp",
    "src/SFML/Window/GlContext.cpp",
    "src/SFML/Window/GlResource.cpp",
    "src/SFML/Window/Joystick.cpp",
    "src/SFML/Window/JoystickManager.cpp",
    "src/SFML/Window/Keyboard.cpp",
    "src/SFML/Window/Mouse.cpp",
    "src/SFML/Window/Sensor.cpp",
    "src/SFML/Window/SensorManager.cpp",
    "src/SFML/Window/Touch.cpp",
    "src/SFML/Window/VideoMode.cpp",
    "src/SFML/Window/Vulkan.cpp",
    "src/SFML/Window/Window.cpp",
    "src/SFML/Window/WindowBase.cpp",
    "src/SFML/Window/WindowImpl.cpp",
};

const network_src_files = [_][]const u8{
    "src/SFML/Network/Ftp.cpp",
    "src/SFML/Network/Http.cpp",
    "src/SFML/Network/IpAddress.cpp",
    "src/SFML/Network/Packet.cpp",
    "src/SFML/Network/Socket.cpp",
    "src/SFML/Network/SocketSelector.cpp",
    "src/SFML/Network/TcpListener.cpp",
    "src/SFML/Network/TcpSocket.cpp",
    "src/SFML/Network/UdpSocket.cpp",
};

const generic_system_src_files = [_][]const u8{
    "src/SFML/System/Clock.cpp",
    "src/SFML/System/Err.cpp",
    "src/SFML/System/FileInputStream.cpp",
    "src/SFML/System/MemoryInputStream.cpp",
    "src/SFML/System/Sleep.cpp",
    "src/SFML/System/String.cpp",
    "src/SFML/System/Utils.cpp",
    "src/SFML/System/Vector2.cpp",
    "src/SFML/System/Vector3.cpp",
};

const windows_system_src_files = [_][]const u8{
    "src/SFML/System/Win32/SleepImpl.cpp",
};

const graphics_src_files = [_][]const u8{
    "src/SFML/Graphics/BlendMode.cpp",
    "src/SFML/Graphics/CircleShape.cpp",
    "src/SFML/Graphics/ConvexShape.cpp",
    "src/SFML/Graphics/Font.cpp",
    "src/SFML/Graphics/GLCheck.cpp",
    "src/SFML/Graphics/GLExtensions.cpp",
    "src/SFML/Graphics/Glsl.cpp",
    "src/SFML/Graphics/Image.cpp",
    "src/SFML/Graphics/RectangleShape.cpp",
    "src/SFML/Graphics/RenderStates.cpp",
    "src/SFML/Graphics/RenderTarget.cpp",
    "src/SFML/Graphics/RenderTexture.cpp",
    "src/SFML/Graphics/RenderTextureImplDefault.cpp",
    "src/SFML/Graphics/RenderTextureImplFBO.cpp",
    "src/SFML/Graphics/RenderWindow.cpp",
    "src/SFML/Graphics/Shader.cpp",
    "src/SFML/Graphics/Shape.cpp",
    "src/SFML/Graphics/Sprite.cpp",
    "src/SFML/Graphics/StencilMode.cpp",
    "src/SFML/Graphics/Text.cpp",
    "src/SFML/Graphics/Texture.cpp",
    "src/SFML/Graphics/TextureSaver.cpp",
    "src/SFML/Graphics/Transform.cpp",
    "src/SFML/Graphics/Transformable.cpp",
    "src/SFML/Graphics/VertexArray.cpp",
    "src/SFML/Graphics/VertexBuffer.cpp",
    "src/SFML/Graphics/View.cpp",
};