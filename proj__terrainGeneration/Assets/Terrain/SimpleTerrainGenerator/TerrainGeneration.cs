using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq; 

public class TerrainGeneration : MonoBehaviour {
    ChunkGeneration chunkGen;
    Mesh mesh;
    MeshFilter meshFilter;
    MeshRenderer meshRenderer;
    MeshCollider collider;
    Vector2[] uv;

    private void Start() {
        chunkGen = GameObject.FindGameObjectWithTag("Manager").GetComponent<ChunkGeneration>();
        if (chunkGen == null) {
            return;
        }

        meshFilter = GetComponent<MeshFilter>();
        meshRenderer = GetComponent<MeshRenderer>();
        collider = GetComponent<MeshCollider>();
        meshRenderer.material = chunkGen.terrainMaterial;

        GenerateTerrain();
    }    

    void GenerateTerrain() {
        mesh = new Mesh();
        Vector3[] vertices = new Vector3[(int)((chunkGen.chunkResolution.x + 1) * (chunkGen.chunkResolution.y + 1))];
        uv = new Vector2[vertices.Length];
        int[] triangles;

        for (int i = 0, x = 0; x <= chunkGen.chunkResolution.x; x++) {
            for (int y = 0; y <= chunkGen.chunkResolution.y; y++) {
                float z = Noise(x, y);
                vertices[i] = new Vector3(x * (128 / chunkGen.chunkResolution.x), z, y * (128 / chunkGen.chunkResolution.y));
                float doesSpawn = Mathf.PerlinNoise(x + transform.position.x + chunkGen.seed, y + transform.position.z + chunkGen.seed);

                if(doesSpawn > chunkGen.treesThreshold && y > chunkGen.waterLevel + 5) {
                    float whatSpawns = Mathf.PerlinNoise(x + transform.position.x + (chunkGen.seed * 5), y + transform.position.z + (chunkGen.seed * 3));
                    whatSpawns = whatSpawns * chunkGen.trees.Length;
                    whatSpawns = Mathf.RoundToInt(whatSpawns);
                    GameObject current = Instantiate(chunkGen.trees[(int)whatSpawns], new Vector3(x * (128 / chunkGen.chunkResolution.x) + transform.position.x, z + transform.position.y, y * (128 / chunkGen.chunkResolution.y) + transform.position.z), Quaternion.identity);
                    current.transform.parent = transform;
                }

                i++;
            }
        }

        for (int i = 0; i < uv.Length; i++) {
            uv[i] = new Vector2(vertices[i].x, vertices[i].y);
        }

        triangles = new int[(int)(chunkGen.chunkResolution.x * chunkGen.chunkResolution.y * 6)];
        int tris = 0;
        int verts = 0;

        for (int x = 0; x < chunkGen.chunkResolution.y; x++) {
            for (int y = 0; y < chunkGen.chunkResolution.x; y++) {
                triangles[tris + 0] = verts + 0;
                triangles[tris + 1] = (int)(verts + chunkGen.chunkResolution.x + 1); 
                triangles[tris + 2] = verts + 1;
                triangles[tris + 3] = verts + 1;
                triangles[tris + 4] = (int)(verts + chunkGen.chunkResolution.x + 1); 
                triangles[tris + 5] = (int)(verts + chunkGen.chunkResolution.x + 2); 
                verts++;
                tris += 6;
                
            }

            verts++;
        }

        mesh.Clear();
        mesh.vertices = vertices;
        mesh.triangles = triangles;
        mesh.uv = uv;
        mesh.RecalculateBounds();
        mesh.triangles = mesh.triangles.Reverse().ToArray();
        collider.sharedMesh = mesh;
        mesh.RecalculateNormals();
        meshFilter.mesh = mesh;

    }

    float Noise(float x, float y) {
        float z = Mathf.PerlinNoise(((x * (128 / chunkGen.chunkResolution.x)) + transform.position.x) * 0.009f, ((y * (128 / chunkGen.chunkResolution.y)) + transform.position.z) * 0.002f) * 10f;
        z += Mathf.PerlinNoise(((x * (128 / chunkGen.chunkResolution.x)) + transform.position.x) * 0.0006f, ((y * (128 / chunkGen.chunkResolution.y)) + transform.position.z) * 0.0006f) * 128f;
        return z;
    }
}
