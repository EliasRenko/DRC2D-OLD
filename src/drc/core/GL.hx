package drc.core;

#if js

    typedef GL                  = drc.backend.web.core.GL;
    typedef GLActiveInfo        = drc.backend.web.core.GL.GLActiveInfo;
    typedef GLBuffer            = drc.backend.web.core.GL.GLBuffer;
    typedef GLContextAttributes = drc.backend.web.core.GL.GLContextAttributes;
    typedef GLFramebuffer       = drc.backend.web.core.GL.GLFramebuffer;
    typedef GLProgram           = drc.backend.web.core.GL.GLProgram;
    typedef GLRenderbuffer      = drc.backend.web.core.GL.GLRenderbuffer;
    typedef GLShader            = drc.backend.web.core.GL.GLShader;
    typedef GLTexture           = drc.backend.web.core.GL.GLTexture;
    typedef GLUniformLocation   = drc.backend.web.core.GL.GLUniformLocation;

#elseif cpp

    typedef GL                  = opengl.WebGL;
    typedef GLActiveInfo        = opengl.WebGL.GLActiveInfo;
    typedef GLBuffer            = opengl.WebGL.GLBuffer;
    typedef GLContextAttributes = opengl.WebGL.GLContextAttributes;
    typedef GLFramebuffer       = opengl.WebGL.GLFramebuffer;
    typedef GLProgram           = opengl.WebGL.GLProgram;
    typedef GLRenderbuffer      = opengl.WebGL.GLRenderbuffer;
    typedef GLShader            = opengl.WebGL.GLShader;
    typedef GLTexture           = opengl.WebGL.GLTexture;
    typedef GLUniformLocation   = opengl.WebGL.GLUniformLocation;

#end //!snow_web