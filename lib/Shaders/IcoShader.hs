-- This module defines the shaders needed to render the roof object
module IcoShader where

-- Vertex Shader
icoVertexShaderSource :: String
icoVertexShaderSource = unlines [
    "#version 330 core"
    ,"layout (location = 0) in vec3 position;"
    ,"layout (location = 1) in vec3 normal;"
    ,"layout (location = 2) in vec2 texCoord;"
    ,"uniform vec2 res;"
    ,"uniform mat4 model;"
    ,"uniform mat4 view;"
    ,"uniform mat4 projection;"
    ,"out vec2 u_resolution;"
    ,"out vec3 Normal;"
    ,"out vec3 FragPos;"
    ,"out vec4 ourTri;"
    ,"out vec2 TexCoord;"
    ,"void main()"
    ,"{"
    ,"    gl_Position =  projection * view * model * vec4(position, 1.0);"
    ,"    u_resolution = res;"
    ,"    ourTri = gl_Position;"
    ,"    TexCoord = vec2(texCoord.x, 1.0f - texCoord.y);"
    ,"    FragPos = vec3(model * vec4(position,1.0f));"
    ,"    Normal = mat3(transpose(inverse(model))) * normal; // Set ourColor to the input color we got from the vertex data"
    ,"}"]

-- Fragment Shader
icoFragmentShaderSource :: String
icoFragmentShaderSource = unlines [
    "#version 330 core"
    ,"uniform sampler2D ourTexture1;"
    ,"in vec3 Normal;"
    ,"in vec3 FragPos;"
    ,"in vec2 TexCoord;"
    ,"out vec4 color;"
    ,"in vec2 u_resolution;"
    ,"in vec4 ourTri;"
    ,"uniform vec3 lightPos;"
    ,"uniform vec3 viewPos;"
    ,"uniform vec3 objectColor;"
    ,"uniform vec3 lightColor;"
    ,"void main()"
    ,"{"
    ,"    float ambientStrength = 0.4f;"
    ,"    vec3 ambient = lightColor * ambientStrength;"
    ,"    // diffuse"
    ,"    vec3 lightDir = normalize(lightPos - FragPos);"
    ,"    float diff = max(dot(Normal, lightDir),0.0);"
    ,"    vec3 diffuse = diff * lightColor;"
    ,"    // specular"
    ,"    float specularStrength = 3.0f;"
    ,"    vec3 viewDir = normalize(viewPos - FragPos);"
    ,"    vec3 reflectDir = reflect(-lightDir, Normal);"
    ,"    float spec = pow(max(dot(viewDir, reflectDir),0.0),100);"
    ,"    vec3 specular = specularStrength * spec * lightColor;"  
    ,"    vec3 result = (ambient + diffuse + specular) * objectColor;"
    ,"    // color = texture(ourTexture1,TexCoord);"
    ,"    // color = vec4(result, 1.0f);"
    ,"    color = vec4(result, 1.0f) + texture(ourTexture1,TexCoord);"
    ,"}"]