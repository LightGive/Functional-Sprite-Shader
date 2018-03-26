using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditorInternal;

namespace LightGive
{
	[RequireComponent(typeof(SpriteRenderer))]
	public class SpriteParamChanger : MonoBehaviour
	{
		private const string ShaderParamPixelPerfect = "_PixelPerfect";
		private const string ShaderParamGrid = "_Grid";
		private const string ShaderParamWhiteColor = "_WhiteColor";

		private SpriteRenderer spRenderer;

		void Start()
		{
			spRenderer = this.gameObject.GetComponent<SpriteRenderer>();
		}

		public float WhiteColor
		{
			get { return spRenderer.material.GetFloat(ShaderParamWhiteColor); }
			set { spRenderer.material.SetFloat(ShaderParamWhiteColor, Mathf.Clamp01(value)); }
		}

		public bool IsPixelPerfect
		{
			get { return spRenderer.material.GetFloat(ShaderParamPixelPerfect) >= 1.0f; }
			set { spRenderer.material.SetFloat(ShaderParamPixelPerfect, value ? 1.0f : 0.0f); }
		}

		public int Grid
		{
			get { return spRenderer.material.GetInt(ShaderParamGrid); }
			set { spRenderer.material.SetInt(ShaderParamGrid, Mathf.Clamp(value, 1, 128)); }
		}
	}
}