using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChunkGeneration : MonoBehaviour {
    public Vector2 chunks;
    public Vector2 chunkResolution;
    public Material terrainMaterial;

    private void Start() {
        StartCoroutine(GenerateChunk());
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
