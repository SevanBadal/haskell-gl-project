module Icosahedron where
import Graphics.GL.Types
import Linear
import Data.List

x :: GLfloat
x = 0.525731112119133606 

z :: GLfloat
z = 0.850650808352039932 

e_verticies :: [GLfloat]
e_verticies = [
    0,(-x),z,     1.0, 0.0, 0.0 
    ,z,0,x,       0.0, 0.0, 1.0
    ,z,0,(-x),    0.1, 1.0, 0.0
    ,(-z),0,(-x), 1.0, 0.0, 0.0
    ,(-z),0,x,    0.0, 0.0, 1.0
    ,(-x),z,0,    0.1, 1.0, 0.0
    ,x,z,0,       1.0, 0.0, 0.0
    ,x,(-z),0,    0.0, 0.0, 1.0
    ,(-x),(-z),0, 0.1, 1.0, 0.0
    ,0,(-x),(-z), 1.0, 0.0, 0.0
    ,0,x,(-z),    0.0, 0.0, 1.0
    ,0,x,z,       0.1, 1.0, 0.0 ]

indicies :: [GLuint]
indicies = [
    1, 2, 6,
    1, 7, 2,
    3, 4, 5,
    4, 3, 8,
    6, 5, 11,
    5, 6, 10,
    9, 10, 2,
    10, 9, 3,
    7, 8, 9,
    8, 7, 0,
    11, 0, 1,
    0, 11, 4,
    6, 2, 10,
    1, 6, 11,
    3, 5, 10,
    5, 4, 11,
    2, 7, 9,
    7, 1, 0,
    3, 9, 8,
    4, 8, 0 ] 

-- for debugging
int_verticies :: [GLfloat]
int_verticies = [
    0,(-x),z    
    ,z,0,x      
    ,z,0,(-x)   
    ,(-z),0,(-x)
    ,(-z),0,x   
    ,(-x),z,0   
    ,x,z,0      
    ,x,(-z),0   
    ,(-x),(-z),0
    ,0,(-x),(-z)
    ,0,x,(-z)   
    ,0,x,z]

-- for debugging
int_indicies :: [Int]
int_indicies = [
    1, 2, 6,
    1, 7, 2,
    3, 4, 5,
    4, 3, 8,
    6, 5, 11,
    5, 6, 10,
    9, 10, 2,
    10, 9, 3,
    7, 8, 9,
    8, 7, 0,
    11, 0, 1,
    0, 11, 4,
    6, 2, 10,
    1, 6, 11,
    3, 5, 10,
    5, 4, 11,
    2, 7, 9,
    7, 1, 0,
    3, 9, 8,
    4, 8, 0 ] 

ico_normals :: [GLfloat]
ico_normals = [
    0.000000, -0.417775, 0.675974,
	0.675973, 0.000000, 0.417775,
	0.675973, -0.000000, -0.417775,
	-0.675973, 0.000000, -0.417775,
	-0.675973, -0.000000, 0.417775,
	-0.417775, 0.675974, 0.000000,
	0.417775, 0.675973, -0.000000,
	0.417775, -0.675974, 0.000000,
	-0.417775, -0.675974, 0.000000,
	0.000000, -0.417775, -0.675973,
	0.000000, 0.417775, -0.675974,
	0.000000, 0.417775, 0.675973 ] 

-- Batch object to world transform
dice :: [V3 GLfloat]
dice = [V3 (0) 0 0]

slice :: Int -> Int -> [GLfloat] -> [GLfloat]
slice from to xs = take (to - from + 1) (drop from xs)

verticies :: [GLfloat]
verticies = [
    -- FACE 1: (0,0) - (1,0) - (0.5,1)
    0.8506508,0.0,0.5257311, 0.0, 0.0,
    0.8506508,0.0,-0.5257311, 0.2,0.0,
    0.5257311,0.8506508,0.0, 0.1, 0.25,
    -- FACE 2: 0.5,1 - 0,0 - 1,0
    0.5257311,0.8506508,0.0, 0.3, 0.25,
    0.8506508,0.0,-0.5257311, 0.2, 0.0,
    0.0,0.5257311,-0.8506508, 0.4, 0.0,
    -- FACE 3: 1,0 - 0.5,1 - 0,0 
    -0.5257311,0.8506508,0.0, 0.6, 0.0,
    0.5257311,0.8506508,0.0, 0.5, 0.25,
    0.0,0.5257311,-0.8506508, 0.4, 0.0,
    -- FACE 4: 0.5,1 - 0,0 - 1,0
    0.5257311,0.8506508,0.0, 0.7, 0.25,
    -0.5257311,0.8506508,0.0, 0.6, 0.0,
    0.0,0.5257311,0.8506508, 0.8, 0.0,
    -- FACE 5: 1,0 - 0.5,1 - 0,1
    0.8506508,0.0,0.5257311, 1.0, 0.0,
    0.5257311,0.8506508,0.0, 0.9, 0.25,
    0.0,0.5257311,0.8506508, 0.8, 0.0,
    -- FACE 6: 1,0 - 0.5,1 - 0,0
    0.0,0.5257311,0.8506508, 0.2, 0.25,
    0.0,-0.5257311,0.8506508, 0.1, 0.50,
    0.8506508,0.0,0.5257311, 0.0, 0.25,
    -- FACE 7: 1,0 - 0.5,1 - 0,0
    0.5257311,-0.8506508,0.0, 0.4, 0.25,
    0.8506508,0.0,0.5257311, 0.3, 0.5,
    0.0,-0.5257311,0.8506508, 0.2, 0.25,
    -- FACE 8: (0,1) - (0.5,0) - (1,1)
    0.8506508,0.0,0.5257311, 0.4, 0.5,
    0.5257311,-0.8506508,0.0, 0.5, 0.25,
    0.8506508,0.0,-0.5257311, 0.6, 0.5,
    -- FACE 9: 0.5,1 - 0,0 - 1,0
    0.8506508,0.0,-0.5257311, 0.7, 0.5,
    0.5257311,-0.8506508,0.0, 0.6, 0.25,
    0.0,-0.5257311,-0.8506508, 0.8, 0.25,
    -- FACE 10: 0.5,1 - 0,0 - 1,0
    0.0,-0.5257311,-0.8506508, 0.9, 0.5,
    0.0,0.5257311,-0.8506508, 0.8, 0.25,
    0.8506508,0.0,-0.5257311, 1.0, 0.25,
    -- FACE 11: 0.5,1 - 0,0 - 1,0
    0.0,0.5257311,-0.8506508, 0.1, 0.75,
    0.0,-0.5257311,-0.8506508, 0.0, 0.5,
    -0.8506508,0.0,-0.5257311, 0.2, 0.5,
    -- FACE 12: 0.5,0 - 0,0 - 1,0
    -0.8506508,0.0,-0.5257311, 0.3, 0.75,
    -0.5257311,0.8506508,0.0, 0.2, 0.5,
    0.0,0.5257311,-0.8506508, 0.4, 0.5,
    -- FACE 13: (0,0) - (1,0) - (0.5,1)
    -0.8506508,0.0,-0.5257311, 0.4, 0.5,
    -0.8506508,0.0,0.5257311, 0.6,0.5,
    -0.5257311,0.8506508,0.0, 0.5, 0.75,
    -- FACE 14: 1,0 - 0.5,1 - 0,0
    -0.5257311,0.8506508,0.0, 0.8, 0.5,
    -0.8506508,0.0,0.5257311, 0.7, 0.75,
    0.0,0.5257311,0.8506508, 0.6, 0.5,
    -- FACE 15: 1,0 - 0.5,1 - 0,0
    0.0,-0.5257311,0.8506508, 1.0, 0.5,
    0.0,0.5257311,0.8506508, 0.9, 0.75,
    -0.8506508,0.0,0.5257311, 0.8,  0.5,
    -- FACE 16: 1,0 - 0.5,1 - 0,0
    -0.8506508,0.0,0.5257311, 0.2, 0.75,
    -0.5257311,-0.8506508,0.0, 0.1, 1.0,
     0.0,-0.5257311,0.8506508, 0.0, 0.75,
    -- FACE 17: 0.5,1 - 0,0 - 1,0
    -0.5257311,-0.8506508,0.0, 0.3, 1.0,
    0.5257311,-0.8506508,0.0, 0.2, 0.75,
    0.0,-0.5257311,0.8506508, 0.4, 0.75,
    -- FACE 18: 1,0 - 0.5,1 - 0,0
    0.5257311,-0.8506508,0.0, 0.6, 0.75,
    -0.5257311,-0.8506508,0.0, 0.5, 1.0,
    0.0,-0.5257311,-0.8506508, 0.4, 0.75,
    -- FACE 19 0,0 - 1,0 - 0.5,1
    -0.8506508,0.0,-0.5257311, 0.6, 0.75,
    0.0,-0.5257311,-0.8506508, 0.8, 0.75,
    -0.5257311,-0.8506508,0.0, 0.7, 1.0,
    -- FACE 20: 1,1 - 0,1 - 0.5, 0
    -0.8506508,0.0,0.5257311, 1.0, 1.0,
    -0.8506508,0.0,-0.5257311, 0.8, 1.0,
    -0.5257311,-0.8506508,0.0, 0.9, 0.75]

printVerticies :: [Int] -> IO()
printVerticies [] = return ()
printVerticies [x] = putStr $ show x
printVerticies (x:xs) = do
    putStr "("
    putStr $ intercalate "," $ show <$> (slice (x * 3) (2 + (x * 3)) int_verticies)
    putStr ")"
    putStrLn ""
    printVerticies xs