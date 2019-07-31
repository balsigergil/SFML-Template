workspace "SFML"
    architecture "x86_64"
    configurations { "Debug", "Release" }
    startproject "Sandbox"

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "SFML"
    location "vendor/SFML"
    kind "StaticLib"
    language "C++"
    cppdialect "C++14"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    includedirs
    {
        "%{prj.location}/include",
        "%{prj.location}/src",
        "%{prj.location}/extlibs/headers/AL",
        "%{prj.location}/extlibs/headers/freetype2",
        "%{prj.location}/extlibs/headers/stb_image",
        "%{prj.location}/extlibs/headers",
    }

    files
    {
        "%{prj.location}/src/SFML/Audio/**.hpp",
        "%{prj.location}/src/SFML/Audio/**.cpp",
        "%{prj.location}/src/SFML/Graphics/**.hpp",
        "%{prj.location}/src/SFML/Graphics/**.cpp",
        "%{prj.location}/src/SFML/Network/*.hpp",
        "%{prj.location}/src/SFML/Network/*.cpp",
        "%{prj.location}/src/SFML/System/*.hpp",
        "%{prj.location}/src/SFML/System/*.cpp",
        "%{prj.location}/src/SFML/Window/*.hpp",
        "%{prj.location}/src/SFML/Window/*.cpp",
        "%{prj.location}/include/SFML/**.hpp"
    }

    filter "system:windows"
        systemversion "latest"

        defines
        {
            "SFML_STATIC",
            "_CRT_SECURE_NO_WARNINGS",
            "_WINSOCK_DEPRECATED_NO_WARNINGS"
        }

        files
        {
            "%{prj.location}/src/SFML/Network/Win32/*.hpp",
            "%{prj.location}/src/SFML/Network/Win32/*.cpp",
            "%{prj.location}/src/SFML/System/Win32/*.hpp",
            "%{prj.location}/src/SFML/System/Win32/*.cpp",
            "%{prj.location}/src/SFML/Window/Win32/*.hpp",
            "%{prj.location}/src/SFML/Window/Win32/*.cpp",
        }

        removefiles
        {
            "**/EglContext.cpp",
            "**/EglContext.hpp",
            "**/EGLCheck.cpp",
            "**/EGLCheck.hpp",
        }

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    includedirs
    {
        "vendor/SFML/include"
    }

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/*.cpp"
    }

    libdirs
    {
        "vendor/SFML/extlibs/libs-msvc/x64"
    }

    links {
        "winmm.lib",
        "ws2_32.lib",
        "flac.lib",
        "freetype.lib",
        "ogg.lib",
        "openal32.lib",
        "vorbis.lib",
        "vorbisenc.lib",
        "vorbisfile.lib",
        "opengl32.lib",
        "SFML"
    }

    filter "system:windows"
        systemversion "latest"

        defines "SFML_STATIC"

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"