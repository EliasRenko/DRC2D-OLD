package drc.utils;

import drc.display.Program;
import opengl.WebGL;
import drc.data.Texture;
import drc.display.Uniform;
import drc.display.Attribute;
import drc.display.Vertex;
import drc.display.AttributeFormat;
import drc.data.Profile;
import drc.core.Promise;
import haxe.io.Bytes;
import haxe.io.UInt8Array;
import haxe.Json;
import drc.debug.Log;

#if js

typedef BackendAssets = drc.backend.web.utils.Resources;

#elseif cpp

typedef BackendAssets = drc.backend.native.utils.Resources;

#end

class Res {

    // ** Privates.

    /** @private **/ private var __resources:Map<String, __Resource> = new Map<String, __Resource>();

    public function new() {

    }

    public function getText(name:String):String {

        var _resource:__Resource = __resources.get(name);

        if (_resource == null) {

            return null;
        }

        var _textResource:__TextResource = cast(_resource, __TextResource);

        return _textResource.data;
    }

    public function getProfile(name:String):Profile {

        var _resource:__Resource = __resources.get(name);

        if (_resource == null) {

            return null;
        }

        var _textResource:__ProfileResource = cast(_resource, __ProfileResource);

        return _textResource.data;
    }

    public function loadText(path:String, cache:Bool = true):Promise<String> {

        return new Promise(function(resolve, reject) {
            
            BackendAssets.loadText(path, function(status, response) {

                if (status == 200) { 

                    if (cache) {

                        __resources.set(path, new __TextResource(response));
                    }

                    resolve(response);
                }
                else {
    
                    reject();
                }
            });
        });
    }

    public function loadTexture(path:String, cache:Bool = true):Promise<Texture> {

        return new Promise(function(resolve, reject) {

            BackendAssets.loadTexture(path, function(status, response) {

                if (status == 200) { 
    
                    if (cache) {

                        __resources.set(path, new __TextureResource(response));
                    }

                    resolve(response);
                }
                else {
    
                    reject();
                }
            });
        });
    }

    public function loadProfile(path:String, cache:Bool = true):Promise<Profile> {

        return new Promise(function(resolve, reject) {
            
            BackendAssets.loadText(path, function(status, response) {

                if (status == 200) { 

                    var _rootData:Dynamic = Json.parse(response);

                    var _promises:Array<Promise<String>> = [];

                    if (Reflect.hasField(_rootData, "vertexShader")) {	

                        _promises.push(loadText('res/shaders/' + _rootData.vertexShader));
                    }
                    else {

                        _promises.push(null);
                    }

                    if (Reflect.hasField(_rootData, "fragmentShader")) {	
                        
                        _promises.push(loadText('res/shaders/' + _rootData.fragmentShader));
                    }
                    else {

                        _promises.push(null);
                    }

                    var _promise:Promise<Array<String>> = Promise.all(_promises);

                    _promise.onComplete(function(result:Array<String>, type:Int) {

                        var _profile:Profile = new Profile(_rootData.name);

                        var _vertexShaderSource:String = '';

                        var _fragmentShaderSource:String = '';

                        var dataPerVertex:Int = 0;

                        if (Reflect.hasField(_rootData, "attributes")) {

                            var _attributeData:Dynamic = Reflect.field(_rootData, "attributes");

                            for (i in 0..._attributeData.length) {

                                var _attributeFormat:AttributeFormat = AttributeFormat.VEC4;
            
                                switch (_attributeData[i].format) {
            
                                    case "vec2":
                        
                                        _attributeFormat = AttributeFormat.VEC2;
                                        
                                    case "vec3":
                                        
                                        _attributeFormat = AttributeFormat.VEC3;
                                        
                                    case "vec4":
                                        
                                        _attributeFormat = AttributeFormat.VEC4;
                                        
                                    default:
                                        
                                        Log.print('Unknown attribute format.');
            
                                        reject();
                                }
            
                                var struct:Array<Vertex> = new Array<Vertex>();
                
                                var structData:Dynamic = Reflect.field(_attributeData[i], "struct");
            
                                for (j in 0...structData.length) {
            
                                    var _vertex:Vertex = {

                                        name: structData[j].name,
            
                                        position: dataPerVertex
                                    }
            
                                    struct.push(_vertex);

                                    dataPerVertex ++;
                                }

                                _profile.addAttribute(new Attribute(_attributeData[i].name, _attributeFormat, 0, struct));
                            }
                        }

                        #if debug

                        else {

                            throw "Profile: " + _profile.name + " has no field with name `attributes`.";
                        }

                        #end

                        _profile.dataPerVertex = dataPerVertex;

                        if (Reflect.hasField(_rootData, "uniforms")) {

                            var _uniformData:Dynamic = Reflect.field(_rootData, "uniforms");

                            for (i in 0..._uniformData.length) {

                                _profile.addUniform(new Uniform(_uniformData[i].name, _uniformData[i].format));
                                
                                //_vertexShader_uniforms += "uniform " + _uniformData[i].format + " " + _uniformData[i].name + ";\n";
                            }
                        }

                        #if debug

                        else {

                            throw "Profile: " + _profile.name + " has no field with name `uniforms`.";
                        }

                        #end

                        // ** ---

                        var textures:Array<String> = new Array<String>();

                        if (Reflect.hasField(_rootData, "textures")) {

                            var textureData:Dynamic = Reflect.field(_rootData, "textures");

                            for (textureCount in 0...textureData.length) {

                                _profile.textures[textureCount] = {

                                    name: textureData[textureCount].name,

                                    format: textureData[textureCount].format
                                }
                            }
                        }

                        #if debug

                        else {

                            throw "Profile: " + _profile.name + " has no field with name `textures`.";
                        }

                        #end

                        // ** ---

                        if (result[0] == null) {

                        }
                        else {

                            _vertexShaderSource = result[0];
                        }

                        var _vertexShader:GLShader = WebGL.createShader(WebGL.VERTEX_SHADER);
		
                        WebGL.shaderSource(_vertexShader, _vertexShaderSource);
                        
                        WebGL.compileShader(_vertexShader);

                        if (result[0] == null) {

                        }
                        else {

                            _fragmentShaderSource = result[1];
                        }
                        
                        var _fragmentShader:GLShader = WebGL.createShader(WebGL.FRAGMENT_SHADER);
		
                        WebGL.shaderSource(_fragmentShader, _fragmentShaderSource);
                        
                        WebGL.compileShader(_fragmentShader);

                        // ** ---

                        var _program:Program = new Program(WebGL.createProgram());
                        
                        var _location:Int = 0;

                        for (i in 0..._profile.attributes.length) 
                        {
                            WebGL.bindAttribLocation(_program.innerData, _location, _profile.attributes[i].name);
                            
                            _profile.attributes[i].assignLocation(_location);
                            
                            _location ++;
                        }

                        // ** Attach the vertex shader.

                        WebGL.attachShader(_program.innerData, _vertexShader);
        
                        // ** Attach the fragment shader.

                        WebGL.attachShader(_program.innerData, _fragmentShader);
                        
                        // ** Link the program.

                        WebGL.linkProgram(_program.innerData);

                        if (WebGL.getProgramParameter(_program.innerData, WebGL.LINK_STATUS) == 0) {

                            var _error:String = WebGL.getProgramInfoLog(_program.innerData);

                            throw "Unable to link the shader program: " + _error;
                        }

                        for (i in 0..._profile.uniforms.length) 
                        {
                            var location:Int = WebGL.getUniformLocation(_program.innerData, _profile.uniforms[i].name);
                
                            _profile.uniforms[i].assignLocation(location);
                            
                            #if debug // ------
                            
                            #end // ------
                        }

                        for (i in 0..._profile.textures.length) {

                            var _location:Int = WebGL.getUniformLocation(_program.innerData, _profile.textures[i].name);
                        }
                
                        _profile.program = _program;
                
                        if (cache) {

                            __resources.set(path, new __ProfileResource(_profile));
                        }

                        resolve(_profile);
                    });
                }
                else {
    
                    reject();
                }
            });
        });
    }
}

private class __Resource {

    public function new() {

    }
}

private class __TextResource extends __Resource {

    public var data:String;

    public function new(data:String) {

        super();

        this.data = data;
    }
}

private class __TextureResource extends __Resource {

    public var data:Texture;

    public function new(data:Texture) {

        super();

        this.data = data;
    }
}

private class __ProfileResource extends __Resource {

    public var data:Profile;

    public function new(data:Profile) {

        super();

        this.data = data;
    }
}