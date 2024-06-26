USE [RESPONSI]
GO
/****** Object:  Trigger [dbo].[updateHargaJual]    Script Date: 01/06/2023 09:28:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Arynda Anna Salsabiela>
-- Create date: <Kamis, 1 Juni 2023>
-- Description:	<trigger untuk mengupdate data harga jual produk>
-- =============================================
ALTER TRIGGER [dbo].[updateHargaJual]
   ON  [dbo].[PRODUK]
   FOR INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	UPDATE PRODUK
	SET HargaJual = HargaPokok + (0.05 * HargaPokok)
	FROM PRODUK
END
