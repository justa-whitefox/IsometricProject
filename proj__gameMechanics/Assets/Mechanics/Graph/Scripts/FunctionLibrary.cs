using UnityEngine;
using static UnityEngine.Mathf; //using the static members of namespace Mathf

public static class FunctionLibrary {

    public delegate Vector3 Function(float u, float v, float t);

    public enum FunctionName {Wave, MorphingWave, Ripple, Sphere, TwistedSphere, Torus, TwistedTorus}

    static Function[] functions = {Wave, MorphingWave, Ripple, Sphere, TwistedSphere, Torus, TwistedTorus};

    public static Vector3 Morph(float u, float v, float t, Function from, Function to, float progress) {
        return Vector3.LerpUnclamped(from(u, v, t), to(u, v, t), SmoothStep(0f, 1f, progress));
    }

    public static int FunctionCount => functions.Length;

    public static FunctionName GetNextFunctionName (FunctionName name) => (int)name < functions.Length - 1 ? name + 1 : 0;

    public static FunctionName GetRandomFunctionNameOtherThan(FunctionName name) {
        FunctionName choice = (FunctionName)Random.Range(1, functions.Length); //using Mathf.Random.Range(index, arrayLength); to select a random index of an array
        return choice == name ? 0 : choice;
    }

    public static Function GetFunction (FunctionName name) => functions[(int)name];

    public static Vector3 Wave(float u, float v, float t) { //diagonal sine waves
        Vector3 p;
        p.x = u;
        p.y = Sin(PI * (u + v + t));
        p.z = v;
        return p;
        //f(x, t) = sin(π(x + t)), where t : time, create a constant sine wave ocilation that follow the game time, from -1 to 1
        //f(x) = x^3, y will receive the cube of x, what will create a parabole with y going form -1 to 1
    }

    public static Vector3 MorphingWave(float u, float v, float t) {//Wave slide along another in different dimensions
        Vector3 p;
        p.x = u;
        p.y = Sin(PI * (u + 0.5f * t));
        p.y += 0.5f * Sin(2f * PI * (v + t));
        p.y += Sin(PI * (u + v + 0.25f * t));
        p.y *= 1f / 2.5f;
        p.z = v;
        return p; //the compiler run smoother with multiplication of integer values
    }

    public static Vector3 Ripple(float u, float v, float t) {//sine of distance with animated ripple
        float d = Sqrt(u * u + v * v);
        Vector3 p;
        p.x = u;
        p.y = Sin(PI * (4f * d - t));
        p.y /= 1f + 10f * d;
        p.z = v;
        return p;
        // y = sin(π(4d - t)) / 1 + 10d, make the ripple animate by flowing outward, y = sin(4πd) with d = |x|, d = distance = absolute of x
        //y = sin(4πd) / 1 + 10d, decreae the amplitude of the wave by dicreasing distance
    }

    public static Vector3 Sphere(float u, float v, float t) {
        float r = 0.5f + 0.5f * Sin(PI * t);
        float s = r * Cos(0.5f * PI * v);
        Vector3 p;
        p.x = s * Sin(PI * u);
        p.y = r * Sin(PI * 0.5f * v);
        p.z = s * Cos(PI * u);
        return p;
    }

    public static Vector3 TwistedSphere(float u, float v, float t) {
        float r = 0.9f + 0.1f * Sin(PI * (6f * u + 4f * v + t));
        float s = r * Cos(0.5f * PI * v);
        Vector3 p;
        p.x = s * Sin(PI * u);
        p.y = r * Sin(PI * 0.5f * v);
        p.z = s * Cos(PI * u);
        return p;
    }

    public static Vector3 Torus(float u, float v, float t) {
        float s = 0.75f + 0.25f * Cos(PI * v);
        Vector3 p;
        p.x = s * Sin(PI * u);
        p.y = 0.5f + 0.5f  * (Sin(PI * t)) * Sin(PI * v);
        p.z = s * Cos(PI * u);
        return p;
    }

    public static Vector3 TwistedTorus(float u, float v, float t) {
        float r1 = 0.7f + 0.1f * Sin(PI * (6f * u + 0.5f * t));
        float r2 = 0.15f + 0.05f * Sin(PI * (8f * u + 4f * v + 2f * t));
        float s = r1 + r2 * Cos(PI * v);
        Vector3 p;
        p.x = s * Sin(PI * u);
        p.y = r2 * Sin(PI * v);
        p.z = s * Cos(PI * u);
        return p;
    }

}