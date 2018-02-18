using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// 移動
/// </summary>
public class Move : MonoBehaviour
{
	[SerializeField]
	private Vector3 startAnchor;
	[SerializeField]
	private Vector3 endAnchor;

	[SerializeField]
	private float arriveTime = 5.0f;

	private float timeCnt;


	void Start()
	{
		timeCnt = 0.0f;
	}

 	void Update ()
	{
		timeCnt += Time.deltaTime;
		var l = Mathf.Clamp01(timeCnt / arriveTime);
		transform.position = Vector3.Lerp(startAnchor, endAnchor, l);
	}

	private void OnDrawGizmosSelected()
	{
		Gizmos.DrawWireSphere(startAnchor, 0.05f);
		Gizmos.DrawWireSphere(endAnchor, 0.05f);
		Gizmos.DrawLine(startAnchor, endAnchor);
	}

	public void ResetPosition()
	{
		timeCnt = 0.0f;
	}
}
