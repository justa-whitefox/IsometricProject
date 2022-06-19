using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TreeLogHalf : MonoBehaviour, ITreeDamageable {

    [SerializeField] private Transform fxTreeLogHalfDestroyed;

    private HealthSystem healthSystem;

    private void Awake() {
        healthSystem = new HealthSystem(30);
        healthSystem.OnDead += HealthSystem_OnDead;
    }

    private void HealthSystem_OnDead(object sender, System.EventArgs e) {
        healthSystem.OnDead -= HealthSystem_OnDead;

        Destroy(gameObject);
    }

    public void Damage(int amount) {
        healthSystem.Damage(10);
    }

    private void OnCollisionEnter(Collision collision) {
        if (collision.gameObject.TryGetComponent<ITreeDamageable>(out ITreeDamageable treeDamageable)) {
            //CMDebug.TextPopup("10", collision.contacts[0].point);
            treeDamageable.Damage(10);
        }
    }

}
