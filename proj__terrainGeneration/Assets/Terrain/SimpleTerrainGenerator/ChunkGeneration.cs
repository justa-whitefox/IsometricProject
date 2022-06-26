using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChunkGeneration : MonoBehaviour {
    public Vector2 chunks;
    public Vector2 chunkResolution;
    public Material terrainMaterial;

    public int seed;

    public GameObject water;
    public float waterLevel;
    public GameObject[] trees;
    public float treesThreshold;

    private void Start() {
        waterLevel = Mathf.PerlinNoise(seed, seed) * 50;
        StartCoroutine(GenerateChunk());
        GameObject current = Instantiate(water, new Vector3((128 * chunks.x) / 2, waterLevel, (128 * chunks.y) / 2), Quaternion.identity);
        current.transform.localScale = new Vector3(128, 128, 128);
    }

    public IEnumerator GenerateChunk() {
        for (int x = 0; x < chunks.x; x++) {
            for (int y = 0; y < chunks.y; y++) {
                GameObject current = new GameObject("Terrain" + new Vector2(x * 128, y * 128), typeof(TerrainGeneration), typeof(MeshRenderer), typeof(MeshFilter), typeof(MeshCollider));
                current.transform.parent = transform;
                current.transform.position = new Vector3(x * (chunkResolution.x) * (128 / chunkResolution.x), 0f, y * (chunkResolution.y) * (128 / chunkResolution.y));
                yield return new WaitForSeconds(Time.deltaTime);
            }
        }
    }
}
