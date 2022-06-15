using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeleeSystem : MonoBehaviour {

    public int damage = 50;
    public float distance;
    public float maxDistance = 1.5f;
    public Transform mace;
    RaycastHit hit;

    void Update() {
        if (Input.GetButtonDown("Fire1")) {

            mace.GetComponent<Animation>().Play("Attack");

            if (Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit)) {

                distance = hit.distance;
                if (distance < maxDistance) {
                    hit.transform.SendMessage("Apply Damage", damage, SendMessageOptions.DontRequireReceiver);
                }
                

            }
        }

    }
}
