using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyLogic : MonoBehaviour {
    public int health = 100;

    void Update() {
        if (health <= 0) {
            Dead();

        }
    }

    void ApplyDamage(int damage) {
        health -= damage;

    }

    void Dead() {
        Destroy(gameObject);
    }
}
