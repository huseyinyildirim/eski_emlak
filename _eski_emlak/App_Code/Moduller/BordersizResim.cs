using System.Web.UI.WebControls;

public class BordersizResim : System.Web.UI.WebControls.Image
{
    public override Unit BorderWidth
    {
        get
        {
            if (base.BorderWidth.IsEmpty)
                return Unit.Pixel(0);
            else
                return base.BorderWidth;
        }
        set
        {
            base.BorderWidth = value;
        }
    }
}